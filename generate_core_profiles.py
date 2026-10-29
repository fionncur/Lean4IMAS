"""Generate the complete core_profiles record tree from expanded IMAS DD XML."""

from __future__ import annotations

import argparse
from pathlib import Path
import re
import subprocess
import xml.etree.ElementTree as ET


SUPPORT = """-- Quantity pairs a value with its DD unit at the type level. The unit tag
-- prevents, for example, treating a value in eV as one in Wb without conversion.
-- α is the value type; Float is used when no other type is given.
structure Quantity (unit : Unit) (α : Type := Float) where
  value : α

-- Inhabited supplies a default value when the underlying type has one.
instance [Inhabited α] : Inhabited (Quantity unit α) := ⟨⟨default⟩⟩

-- Rectangular, row-major storage for the DD's two-dimensional arrays.
structure Matrix (α : Type) where
  rows : Nat
  cols : Nat
  data : Array α
  size_eq : data.size = rows * cols  -- proof that the flat storage fits the shape

instance : Inhabited (Matrix α) := ⟨⟨0, 0, #[], rfl⟩⟩

-- For a filled array, at least one coordinate must be filled, and every
-- filled alternative must have the same length as the array's dimension.
-- https://imas-python.readthedocs.io/en/stable/validation.html#validate-coordinates
def coordinateSizesMatch (size : Nat) (coordinates : List Nat) : Bool :=
  coordinates.any (fun n => n != 0) &&
    coordinates.all (fun n => n == 0 || n == size)

-- The DD ties global_quantities/ion to profiles_1d/ion at the time in
-- global_quantities/ion_time_slice. IMAS-Python currently skips this
-- cross-array coordinate lookup (IMAS-4675); it is not enforced here either.
"""


def identifier(name: str) -> str:
    """Keep the DD spelling, adding Lean quoting only when required."""
    if re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", name) and name not in {"type", "local"}:
        return name
    if any(char in name for char in "«»\n\r"):
        raise ValueError(f"Cannot quote Lean identifier: {name!r}")
    return f"«{name}»"


def coordinate_constraints(nodes: list[tuple[tuple[str, ...], ET.Element]]) -> dict[tuple[str, ...], list[tuple[str, str]]]:
    """Place each coordinate-size proof at the nearest common parent record."""
    fields = dict(nodes)
    checks: dict[tuple[str, ...], list[tuple[str, str]]] = {}

    def path_of(reference: str) -> tuple[str, ...]:
        return tuple(re.sub(r"\([^)]*\)", "", part) for part in reference.split("/"))

    def array_path(path: tuple[str, ...], parent: tuple[str, ...], prefix: str = "") -> tuple[str, list[tuple[str, str]]]:
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
                    f"({name}.size == 0 || "
                    f"((ids_properties.homogeneous_time == some 1 && {name}.size == time.size) || "
                    f"(ids_properties.homogeneous_time == some 0 && "
                    f"{name}.toList.all (fun item => item.time.isSome))))"
                )
                checks.setdefault((), []).append((f"coordinate_{name}_1", condition))
            elif reference not in (None, "1...N", "profiles_1d(itime)/ion"):
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
                    filled = f"{value}.size != 0" if rank == 1 else f"{value}.data.size != 0"
                    actual = f"{value}.size" if rank == 1 else f"{value}.{'rows' if dim == 1 else 'cols'}"
                    condition = f"(!({filled}) || {actual} == {fixed[1]})"
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
                filled = f"{value}.size != 0" if rank == 1 else f"{value}.data.size != 0"
                actual = f"{value}.size" if rank == 1 else f"{value}.{'rows' if dim == 1 else 'cols'}"
                sizes = []
                for other in alternatives:
                    expression, _ = array_path(other, parent)
                    other_rank = int(fields[other].get("data_type")[-2])
                    other_dim = dim if key.endswith("_same_as") else 1
                    sizes.append(f"{expression}.size" if other_rank == 1 else f"{expression}.{'rows' if other_dim == 1 else 'cols'}")
                condition = f"(!({filled}) || coordinateSizesMatch {actual} [{', '.join(sizes)}])"
                for name, collection in reversed(bindings):
                    condition = f"({collection}.toList.all fun {name} => {condition})"
                field_name = "coordinate_" + "_".join(path[len(parent):]) + f"_{dim}"
                if key.endswith("_same_as"):
                    field_name += "_same_as"
                checks.setdefault(parent, []).append((field_name, condition))
    return checks


def generate(xml: bytes) -> tuple[str, int]:
    root = ET.fromstring(xml)
    if root.tag != "IDSs":
        raise ValueError("Expected expanded IDSDef.xml, not source XSD files")
    ids = root.find("IDS[@name='core_profiles']")
    if ids is None:
        raise ValueError("XML has no core_profiles IDS")

    nodes: list[tuple[tuple[str, ...], ET.Element]] = []

    def walk(element: ET.Element, path: tuple[str, ...] = ()) -> None:
        nodes.append((path, element))
        for child in element.findall("field"):
            walk(child, path + (child.attrib["name"],))

    walk(ids)
    checks = coordinate_constraints(nodes)
    units = {node.attrib["units"] for _, node in nodes if "units" in node.attrib}

    def record_name(path: tuple[str, ...]) -> str:
        # A slash-separated DD path is one Lean identifier, not a namespace.
        return f"«{'/'.join((ids.attrib['name'], *path))}»"

    def record_type(path: tuple[str, ...]) -> str:
        return f"IMAS.{record_name(path)}"

    def quantity(payload: str, unit: str) -> str:
        if payload == "Float":
            return f"Quantity .{identifier(unit)}"
        argument = f"({payload})" if " " in payload else payload
        return f"Quantity .{identifier(unit)} {argument}"

    def field_type(path: tuple[str, ...], node: ET.Element) -> str:
        dtype, unit = node.attrib["data_type"], node.get("units")
        if dtype in {"structure", "struct_array"}:
            payload = record_type(path) if dtype == "structure" else f"Array {record_type(path)}"
            return quantity(payload, unit) if unit is not None else payload
        match = re.fullmatch(r"(FLT|INT|STR)_([012])D", dtype)
        if not match or (match[1] == "STR" and match[2] == "2"):
            raise ValueError(f"core_profiles/{'/'.join(path)}: unsupported type {dtype}")
        scalar = {"FLT": "Float", "INT": "Int32", "STR": "String"}[match[1]]
        if unit is not None:
            scalar = quantity(scalar, unit)
        container = ("Option", "Array", "Matrix")[int(match[2])]
        return f"{container} ({scalar})" if " " in scalar else f"{container} {scalar}"

    lines = ["-- Generated from IMAS DD core_profiles. Regenerate rather than editing.",
             "-- Each record is named by its DD path; «...» makes the path one Lean name.",
             "-- Option means a scalar may be missing; Array and Matrix represent arrays.",
             "-- Defaults make it possible to construct a partial IDS without filling every field.",
             "-- The source XML's unit spellings are retained as tags; «...» is Lean quoting.",
             "import Std", "", "namespace IMAS", "", "inductive Unit where"]
    for unit in sorted(units):
        lines.append(f"  | {identifier(unit)}")
    lines.extend(["  deriving DecidableEq", "", SUPPORT.rstrip(), ""])

    def emit(element: ET.Element, path: tuple[str, ...] = ()) -> None:
        for child in element.findall("field"):
            if child.get("data_type") in {"structure", "struct_array"}:
                emit(child, path + (child.attrib["name"],))
        lines.append(f"structure {record_name(path)} where")
        for child in element.findall("field"):
            name = child.attrib["name"]
            if not re.fullmatch(r"[a-z][a-z0-9_]*", name):
                raise ValueError(f"Unsupported field name: {name!r}")
            lean_name = identifier(name)
            lines.append(f"  {lean_name} : {field_type(path + (name,), child)} := default")
        constraints = checks.get(path, [])
        if constraints:
            lines.append("  -- DD coordinate sizes for populated arrays; see coordinateSizesMatch above.")
            def combine(items: list[str]) -> str:
                if len(items) == 1:
                    return items[0]
                middle = len(items) // 2
                return f"({combine(items[:middle])} &&\n     {combine(items[middle:])})"
            lines.append(f"  coordinates_valid : {combine([condition for _, condition in constraints])} = true")
            lines.extend(["", f"instance : Inhabited {record_name(path)} := ⟨{{"])
            for child in element.findall("field"):
                if child.get("data_type") == "struct_array" and child.get("units") is None:
                    lines.append(f"  {identifier(child.attrib['name'])} := #[]")
            lines.append("  coordinates_valid := by decide")
            lines.extend(["}⟩", ""])
        else:
            lines.extend(["  deriving Inhabited", ""])

    emit(ids)
    lines.append("end IMAS")
    return "\n".join(lines) + "\n", len(nodes) - 1


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    source = parser.add_mutually_exclusive_group()
    source.add_argument("--dd-version", default=None, help="Installed DD version (default: 4.1.1)")
    source.add_argument("--xml", type=Path, help="Expanded IDSDef.xml")
    parser.add_argument("--output", type=Path, default=Path("generated/core_profiles.lean"))
    parser.add_argument("--check", action="store_true", help="Also type-check the generated file with Lean")
    args = parser.parse_args()
    try:
        if args.xml:
            xml = args.xml.read_bytes()
        else:
            from imas.dd_zip import get_dd_xml
            xml = get_dd_xml(args.dd_version or "4.1.1")
        lean, fields = generate(xml)
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(lean, encoding="utf-8")
        print(f"Generated {args.output}: {fields} fields", flush=True)
        if args.check:
            subprocess.run(["lean", str(args.output)], check=True)
            print("Lean type-check passed")
    except (ValueError, OSError, ET.ParseError, subprocess.CalledProcessError) as exc:
        parser.exit(1, f"{exc}\n")


if __name__ == "__main__":
    main()
