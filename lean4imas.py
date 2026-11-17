"""Read-only Python API for the Lean4IMAS checker."""

import json
import struct
import subprocess
from dataclasses import dataclass
from pathlib import Path

from imas.ids_defs import (
    EMPTY_FLOAT,
    IDS_TIME_MODE_HETEROGENEOUS,
    IDS_TIME_MODE_HOMOGENEOUS,
)
from imas.ids_toplevel import IDSToplevel


_CHECKER = Path(__file__).resolve().parent / ".lake" / "build" / "bin" / "lean4imas-regrid"


@dataclass(frozen=True)
class RegridResult:
    passed: bool
    message: str


def _float_bits(value: float) -> str:
    """Encode a binary64 as a decimal UInt64 string for Lean's JSON decoder."""
    bits, = struct.unpack(">Q", struct.pack(">d", value))
    return str(bits)


def _slice_input(ids: IDSToplevel, index: int) -> dict:
    profile = ids.profiles_1d[index]
    time_mode = ids.ids_properties.homogeneous_time.value
    time = EMPTY_FLOAT
    if time_mode == IDS_TIME_MODE_HOMOGENEOUS:
        time = ids.time.value[index]
    elif time_mode == IDS_TIME_MODE_HETEROGENEOUS:
        time = profile.time.value

    return {
        "time": None if time == EMPTY_FLOAT else _float_bits(time),
        "rho_tor_norm": [_float_bits(radius) for radius in profile.grid.rho_tor_norm.value],
        "temperature": [_float_bits(value) for value in profile.electrons.temperature.value],
    }


def check_regrid(
    source: IDSToplevel,
    target: IDSToplevel,
    *,
    tolerance_ev: float,
    source_slice: int = 0,
    target_slice: int = 0,
) -> RegridResult:
    """Check a same-time electron temperature regrid on the stored rho_tor_norm grids.

    Pass two DD 4.1.1 core_profiles IDSs and the indices of the slices to compare.
    The Lean checker uses the exact values of the stored binary64 samples and the
    binary64 absolute tolerance in eV. Build it with `lake build lean4imas-regrid`.
    """
    request = {
        "source": _slice_input(source, source_slice),
        "target": _slice_input(target, target_slice),
        "tolerance_ev": _float_bits(tolerance_ev),
    }
    completed = subprocess.run(
        [str(_CHECKER)],
        input=json.dumps(request),
        stdout=subprocess.PIPE,
        text=True,
        check=True,
    )
    return RegridResult(**json.loads(completed.stdout))
