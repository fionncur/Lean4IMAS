"""Generate the complete core_profiles record tree from expanded IMAS DD XML."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import re
import subprocess
import xml.etree.ElementTree as ET


def identifier(name: str) -> str:
    """Keep the DD spelling, adding Lean quoting only when required."""
    if re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", name) and name not in {"type", "local"}:
        return name
    if any(char in name for char in "«»\n\r"):
        raise ValueError(f"Cannot quote Lean identifier: {name!r}")
    return f"«{name}»"


def coordinate_constraints(nodes: list[tuple[tuple[str, ...], ET.Element]], ids_name: str) -> tuple[
    dict[tuple[str, ...], list[tuple[str, str]]],
    dict[tuple[str, ...], dict[tuple, list[str]]],
]:
    """Place each coordinate-size check at the nearest common parent record."""
    fields = dict(nodes)
    checks: dict[tuple[str, ...], list[tuple[str, str]]] = {}
    # Group dimensions only when they have the same coordinates and are reached
    # through the same structure arrays. Sizes can be grouped even when element
    # types or units differ.
    groups: dict[tuple[str, ...], dict[tuple, list[str]]] = {}

    def path_of(reference: str) -> tuple[str, ...]:
        return tuple(re.sub(r"\([^)]*\)", "", part) for part in reference.split("/"))

    def array_path(path: tuple[str, ...], parent: tuple[str, ...], prefix: str = "data") -> tuple[str, list[tuple[str, str]]]:
        """Build a Lean field expression, binding any intervening structure arrays."""
        expression = prefix
        bindings: list[tuple[str, str]] = []
        for index in range(len(parent), len(path)):
            part = path[index]
            expression = f"{expression}.{part}" if expression else part
            node = fields[path[:index + 1]]
            if node.get("units") and node.get("data_type") in {"structure", "struct_array"}:
                expression += ".value"
            if index < len(path) - 1 and node.get("data_type") == "struct_array":
                name = f"item{index}"
                bindings.append((name, expression))
                expression = name
        return expression, bindings

    for path, node in nodes:
        dtype = node.get("data_type", "")
        if dtype == "struct_array":
            reference = node.get("coordinate1")
            if reference and path_of(reference) == path + ("time",):
                # For dynamic structure arrays, IMAS uses root time in homogeneous
                # mode and each element's time in heterogeneous mode.
                if len(path) != 1:
                    raise ValueError(f"Unsupported nested time coordinate: {'/'.join(path)}")
                name = path[0]
                condition = (
                    f"(data.{name}.size == 0 || "
                    f"((data.ids_properties.homogeneous_time == some 1 && data.{name}.size == data.time.size) || "
                    f"(data.ids_properties.homogeneous_time == some 0 && "
                    f"data.{name}.toList.all (fun item => item.time.isSome))))"
                )
                checks.setdefault((), []).append((f"coordinate_{name}_1", condition))
            elif reference == "profiles_1d(itime)/ion" and ids_name == "core_profiles" and path == ("global_quantities", "ion"):
                # IMAS-Python skips this time-dependent cross-array lookup (IMAS-4675).
                continue
            elif reference not in (None, "1...N"):
                raise ValueError(f"Unsupported structure-array coordinate: {'/'.join(path)}: {reference}")
            continue
        if not re.fullmatch(r"(?:FLT|INT|STR)_[12]D", dtype):
            continue
        rank = int(dtype[-2])
        for dim in range(1, rank + 1):
            for key in (f"coordinate{dim}", f"coordinate{dim}_same_as"):
                reference = node.get(key)
                if not reference or reference == "1...N":
                    continue
                fixed = re.fullmatch(r"1\.\.\.(\d+)", reference)
                if fixed:
                    parent = path[:-1]
                    value, _ = array_path(path, parent)
                    empty = f"{value}.size == 0" if rank == 1 else f"{value}.data.size == 0"
                    actual = f"{value}.size" if rank == 1 else f"{value}.{'rows' if dim == 1 else 'cols'}"
                    condition = f"({empty} || {actual} == {fixed[1]})"
                    checks.setdefault(parent, []).append((f"coordinate_{path[-1]}_{dim}", condition))
                    continue
                target = path_of(reference)
                if target not in fields:
                    raise ValueError(f"Unknown coordinate {reference} for {'/'.join(path)}")
                target_node = fields[target]
                if target_node.get("data_type") not in {"FLT_1D", "INT_1D", "STR_1D", "FLT_2D", "INT_2D"}:
                    raise ValueError(f"Unsupported coordinate {reference} for {'/'.join(path)}")
                alternatives = [target]
                if not key.endswith("_same_as"):
                    alternatives += [path_of(x) for x in target_node.get("alternative_coordinate1", "").split(";") if x]
                for alternative in alternatives:
                    if alternative not in fields:
                        raise ValueError(f"Unknown alternative coordinate {'/'.join(alternative)} for {'/'.join(path)}")
                common = list(path[:-1])
                for other in alternatives:
                    while tuple(common) != other[:len(common)]:
                        common.pop()
                parent = tuple(common)
                for other in alternatives:
                    if any(fields[other[:i]].get("data_type") == "struct_array" for i in range(len(parent) + 1, len(other))):
                        raise ValueError(f"Coordinate {reference} crosses a structure array for {'/'.join(path)}")
                value, bindings = array_path(path, parent)
                actual = f"{value}.size" if rank == 1 else f"{value}.{'rows' if dim == 1 else 'cols'}"
                sizes = []
                for other in alternatives:
                    expression, _ = array_path(other, parent)
                    other_rank = int(fields[other].get("data_type")[-2])
                    other_dim = dim if key.endswith("_same_as") else 1
                    sizes.append(f"{expression}.size" if other_rank == 1 else f"{expression}.{'rows' if other_dim == 1 else 'cols'}")
                group = (tuple(bindings), tuple(sizes), rank)
                entry = actual if rank == 1 else f"({value}.data.size, {actual})"
                groups.setdefault(parent, {}).setdefault(group, []).append(entry)
    return checks, groups


def generate(xml: bytes, ids_name: str = "core_profiles") -> tuple[str, int]:
    root = ET.fromstring(xml)
    if root.tag != "IDSs":
        raise ValueError("Expected expanded IDSDef.xml, not source XSD files")
    ids = next((element for element in root.findall("IDS") if element.get("name") == ids_name), None)
    if ids is None:
        raise ValueError(f"XML has no {ids_name} IDS")

    nodes: list[tuple[tuple[str, ...], ET.Element]] = []

    def walk(element: ET.Element, path: tuple[str, ...] = ()) -> None:
        nodes.append((path, element))
        for child in element.findall("field"):
            walk(child, path + (child.attrib["name"],))

    walk(ids)
    checks, groups = coordinate_constraints(nodes, ids_name)

    def record_name(path: tuple[str, ...]) -> str:
        # A slash-separated DD path is one Lean identifier.
        return f"«{'/'.join((ids.attrib['name'], *path))}»"

    def record_type(path: tuple[str, ...]) -> str:
        return f"IMAS.{record_name(path)}"

    def quantity(payload: str, unit: str) -> str:
        if payload == "Float":
            return f"Quantity {json.dumps(unit, ensure_ascii=False)}"
        argument = f"({payload})" if " " in payload else payload
        return f"Quantity {json.dumps(unit, ensure_ascii=False)} {argument}"

    def field_type(path: tuple[str, ...], node: ET.Element) -> str:
        dtype, unit = node.attrib["data_type"], node.get("units")
        if dtype in {"structure", "struct_array"}:
            payload = record_type(path) if dtype == "structure" else f"Array {record_type(path)}"
            return quantity(payload, unit) if unit is not None else payload
        match = re.fullmatch(r"(FLT|INT|STR)_([012])D", dtype)
        if not match or (match[1] == "STR" and match[2] == "2"):
            raise ValueError(f"{ids_name}/{'/'.join(path)}: unsupported type {dtype}")
        scalar = {"FLT": "Float", "INT": "Int32", "STR": "String"}[match[1]]
        if unit is not None:
            scalar = quantity(scalar, unit)
        container = ("Option", "Array", "Matrix")[int(match[2])]
        return f"{container} ({scalar})" if " " in scalar else f"{container} {scalar}"

    lines = [f"-- Generated from IMAS DD {ids_name}. Regenerate rather than editing.",
             "-- Each record is named by its DD path; «...» makes the path one Lean name.",
             "-- Option means a scalar may be missing; Array and Matrix represent arrays.",
             "-- Defaults make it possible to construct a partial IDS without filling every field.",
             "-- Unit tags retain the source XML's spellings.",
             "import Validation", "", "namespace IMAS", ""]
    if ids_name == "core_profiles":
        lines.extend(["-- IMAS-Python skips global_quantities/ion's time-dependent coordinate",
                      "-- lookup into profiles_1d/ion (IMAS-4675); it is not enforced here.", ""])

    def combine(items: list[str]) -> str:
        # Lean's && already associates; parentheses around a balanced tree make
        # generated checks much harder to read.
        return " &&\n  ".join(items) if items else "true"

    def emit(element: ET.Element, path: tuple[str, ...] = ()) -> None:
        for child in element.findall("field"):
            if child.get("data_type") in {"structure", "struct_array"}:
                emit(child, path + (child.attrib["name"],))
        lines.append(f"structure {record_name(path)} where")
        for child in element.findall("field"):
            name = child.attrib["name"]
            if not re.fullmatch(r"[a-z][a-z0-9_]*", name):
                raise ValueError(f"Unsupported field name: {name!r}")
            lines.append(f"  {identifier(name)} : {field_type(path + (name,), child)} := default")
        lines.extend(["  deriving Inhabited", ""])

    emit(ids)

    # Validate children recursively: a check placed on one record must also be
    # enforced when that record appears anywhere within an enclosing IDS.
    needed: dict[tuple[str, ...], dict[str, bool]] = {}

    def emit_validation(element: ET.Element, path: tuple[str, ...] = ()) -> None:
        children = element.findall("field")
        for child in children:
            if child.get("data_type") in {"structure", "struct_array"}:
                emit_validation(child, path + (child.attrib["name"],))
        for kind in ("coordinates", "storage"):
            conditions = [condition for _, condition in checks.get(path, [])] if kind == "coordinates" else []
            coordinate_lists: dict[tuple[str, ...], str] = {}
            if kind == "coordinates":
                # Share each coordinate list across fields and structure arrays.
                for (bindings, sizes, rank), lengths in groups.get(path, {}).items():
                    if sizes not in coordinate_lists:
                        coordinate_lists[sizes] = f"coordinates{len(coordinate_lists) + 1}"
                    coordinates = coordinate_lists[sizes]
                    if rank == 1 and len(lengths) == 1:
                        condition = f"({lengths[0]} == 0 || coordinateSizesMatch {lengths[0]} {coordinates})"
                    else:
                        fields_list = ",\n    ".join(lengths)
                        argument = "size" if rank == 1 else "(stored, size)"
                        empty = "size == 0" if rank == 1 else "stored == 0"
                        condition = (f"([{fields_list}].all fun {argument} =>\n"
                                     f"    {empty} || coordinateSizesMatch size {coordinates})")
                    for binding, collection in reversed(bindings):
                        condition = f"({collection}.toList.all fun {binding} =>\n    {condition})"
                    conditions.append(condition)
            for child in children:
                name = identifier(child.attrib["name"])
                dtype = child.get("data_type", "")
                child_path = path + (child.attrib["name"],)
                value = f"data.{name}"
                if dtype in {"structure", "struct_array"}:
                    if not needed[child_path][kind]:
                        continue
                    if child.get("units") is not None:
                        value += ".value"
                    fn = f"{record_name(child_path)}.{kind}ValidBool"
                    conditions.append(f"{value}.toList.all {fn}" if dtype == "struct_array" else f"{fn} {value}")
                elif kind == "storage" and re.fullmatch(r"(?:FLT|INT|STR)_2D", dtype):
                    conditions.append(f"{value}.storageValid")
            needed.setdefault(path, {})[kind] = bool(conditions)
            if conditions:
                name = record_name(path)
                lines.append(f"def {name}.{kind}ValidBool (data : {name}) : Bool :=")
                if kind == "coordinates" and any(rank == 2 for _, _, rank in groups.get(path, {})):
                    lines.append("  -- Matrix pairs contain storage length and the dimension being checked.")
                for sizes, variable in coordinate_lists.items():
                    if len(sizes) == 1:
                        lines.append(f"  let {variable} := [{sizes[0]}]")
                    else:
                        items = ",\n    ".join(sizes)
                        lines.append(f"  let {variable} := [{items}]")
                lines.extend([f"  {combine(conditions)}", ""])
        name = record_name(path)
        for kind in ("coordinates", "storage"):
            if needed[path][kind]:
                lines.extend([f"def {name}.{kind}Valid (data : {name}) : Prop :=",
                              f"  {name}.{kind}ValidBool data = true", "",
                              f"instance (data : {name}) : Decidable ({name}.{kind}Valid data) :=",
                              f"  inferInstanceAs (Decidable ({name}.{kind}ValidBool data = true))", ""])
        if needed[path]["coordinates"] or needed[path]["storage"]:
            props = [f"{name}.{kind}Valid data" for kind in ("coordinates", "storage") if needed[path][kind]]
            lines.extend([f"def {name}.isValid (data : {name}) : Prop :=",
                          f"  {' ∧ '.join(props)}", "",
                          f"instance (data : {name}) : Decidable ({name}.isValid data) := by",
                          f"  unfold {name}.isValid", "  infer_instance", ""])

    emit_validation(ids)
    lines.append("end IMAS")
    return "\n".join(lines) + "\n", len(nodes) - 1


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    source = parser.add_mutually_exclusive_group()
    source.add_argument("--dd-version", default=None, help="Installed DD version (default: 4.1.1)")
    source.add_argument("--xml", type=Path, help="Expanded IDSDef.xml")
    parser.add_argument("--ids", default="core_profiles", help="IDS name (default: core_profiles)")
    parser.add_argument("--output", type=Path, help="Output path (default: generated/<IDS>.lean)")
    parser.add_argument("--check", action="store_true", help="Also type-check the generated file with Lean")
    args = parser.parse_args()
    try:
        if args.xml:
            xml = args.xml.read_bytes()
        else:
            from imas.dd_zip import get_dd_xml
            xml = get_dd_xml(args.dd_version or "4.1.1")
        lean, fields = generate(xml, args.ids)
        if args.output is None:
            args.output = Path("generated") / f"{args.ids}.lean"
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(lean, encoding="utf-8")
        print(f"Generated {args.output}: {fields} fields", flush=True)
        if args.check:
            subprocess.run(["lake", "build", "Validation"], check=True)
            subprocess.run(["lake", "env", "lean", str(args.output)], check=True)
            print("Lean type-check passed")
    except (ValueError, OSError, ET.ParseError, subprocess.CalledProcessError) as exc:
        parser.exit(1, f"{exc}\n")


if __name__ == "__main__":
    main()
