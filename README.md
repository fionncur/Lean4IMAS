# Lean4IMAS - Automatic formalization of IMAS Data-Dictionary IDSs 

This project is a proof of concept to demonstrate the formalization of the IMAS Data Dictionary into Lean 4 records, to allow formal certificates for the validation of data structures and transformations of IMAS data. The current focus is on the `core_profiles` IDS. 

The generator `generate_core_profiles.py` reads the expanded Data Dictionary XML provided by IMAS-Python and produces Lean records that retain the `core_profiles` hierarchy and field types. The project also includes an example certificate for a temperature profile, using an idealized piecewise-affine mapping between poloidal and toroidal coordinates.

A primary motivation for the IMAS Data Dictionary is to support interoperability between plasma physics and fusion codes by providing a shared, machine-readable description of their inputs and outputs. The same IDS can also represent experimental data from different devices, facilitating the comparison (and compilation) of results. Formalizing these structures in Lean provides a foundation for *stating* and *proving properties* of IMAS data, and especially of *transformations* applied to it, noting that the numerical implementation of such transformations is the substance of a simulation code. 

Since IMAS can represent both simulation and experimental data in the same structures, formalization could provide a common foundation for the systematic comparison of simulation and experimental data; for example, through a formally specified and verified forward diagnostic model that maps simulation quantities to experimental quantities.

## Architecture

The project separates the data from the conditions we want it to satisfy:

- **Raw records:** generated Lean structures represent the IDS fields. They can hold incomplete or invalid data without requiring a proof to construct them.
- **Validation predicates:** generated checks express the supported DD coordinate and time relationships. A predicate is a statement about a record, such as whether its coordinate sizes are valid.
- **Certified records:** `IMAS.Certified` pairs a record with a proof of a chosen predicate. Other predicates, such as future physical requirements for regridding, can be added without changing the raw records.

[Validation.lean](Lean4IMAS/Validation.lean) defines the shared types and certification mechanism. The transformation example adds its own assumptions to a certified profile slice and applies the mathematical results in [ProfileTransform.lean](Lean4IMAS/Transformations/ProfileTransform.lean). This keeps DD validation separate from the conditions needed for a particular transformation.

## `core_profiles` → Lean

The generator can be run as follows:

```sh
python3 generate_core_profiles.py --check
```

This outputs [Lean4IMAS/Generated/core_profiles.lean](Lean4IMAS/Generated/core_profiles.lean), a Lean file containing **890 fields** for every node in the `core_profiles` IDS, preserving the hierarchy, field types and unit tags, and including error fields and `ids_properties`. Each record is named directly by its DD path. For example, `core_profiles/profiles_1d/electrons` becomes `IMAS.«core_profiles/profiles_1d/electrons»`. The quotes make the path a single Lean name, while fields retain their original names and use normal dot access.

The generator also produces separate predicates for partial *validation* of the data structure, currently focused on [coordinate validation](https://imas-python.readthedocs.io/en/stable/validation.html#validate-coordinates). In IMAS-Python, these (and other relationships!) are checked by the `.validate()` method. For `core_profiles`, DD 4.1.1 and IMAS-Python 2.3.0 we have implemented that:

- Coordinate arrays must match populated data arrays in size, including each dimension of a matrix.
- Alternative coordinates and `coordinate*_same_as` size relationships.
- Empty dependent arrays don’t require filled coordinates.
- For dynamic arrays of structures such as `profiles_1d`: homogeneous time uses the root time array; heterogeneous time requires a time in each slice.
- Matrix storage must have `rows * cols` elements.

We have not yet implemented:

- Checking that `ids_properties/homogeneous_time` is a valid time mode.
- Rejecting all populated time-dependent fields when the time mode is independent.
- Checking the time-dependent `global_quantities/ion` relationship to `profiles_1d/ion`; IMAS-Python currently skips this lookup too (IMAS-4675).
- General IDS import, including empty float/int sentinel handling across all fields. The regridding adapter `lean4imas.py` currently imports only selected profile fields and maps a missing time to `none`.

As an example excerpt of a field, the `core_profiles/profiles_1d(itime)/electrons` node looks like:

```lean
structure «core_profiles/profiles_1d/electrons» where
  temperature : Array (Quantity "eV") := default
  temperature_error_upper : Array (Quantity "eV") := default
  temperature_error_lower : Array (Quantity "eV") := default
  temperature_validity : Option Int32 := default
  ...
```

Here, the coordinate array sizing constraints are checked by the `profiles_1d` validity predicate. The individual `electrons` record cannot check the grid stored in the sibling node.

Some conventions for the translation of the data structure to Lean are that:

- Floating point values use `Float`, integers use `Int32`, text uses `String`.
- Scalars use `Option`. `none` means missing, `some value` means present.
- One dimensional arrays use `Array`, two-dimensional arrays use `Matrix` (general N-d arrays not yet implemented).
- Units are tags with the original DD spelling, such as `"s"`, `"Wb"` and `"m^-3"`.
- Fields default to empty values (like with IMAS data), so partially filled records can be constructed and can be valid.

Here is an example of assigning data to a profile slice and certifying that it satisfies the generated `isValid` predicate:

```lean
def slice : IMAS.«core_profiles/profiles_1d» := {
  grid := { rho_pol_norm := #[⟨0⟩, ⟨1⟩] }
  electrons := {
    temperature := #[⟨1200.0⟩, ⟨1500.0⟩]
    temperature_validity := some 0
  }
}

def certifiedSlice : IMAS.Certified IMAS.«core_profiles/profiles_1d»
    IMAS.«core_profiles/profiles_1d».isValid :=
  ⟨slice, by decide +kernel⟩
```

Here `⟨...⟩` pairs the slice with its proof, and `by decide +kernel` asks Lean to check the predicate for this data. [CoordinateTests.lean](Lean4IMAS/CoordinateTests.lean) contains valid and invalid examples. Run `lake build` to check the project and these tests.

## One formalized transformation of IMAS data

Different codes may describe a radial profile using normalized poloidal or toroidal flux coordinates. These are related by a coordinate transformation which should leave the profile invariant. The transformation depends on the MHD equilibrium (we shall later extend the generator for the `equilibrium` IDS), and relates the simultaneous poloidal and toroidal fluxes on the same flux surface.

For an equilibrium $E$ with a relation $\Phi_E(\psi)$ (single-valued) between poloidal flux $\psi$ and toroidal flux $\Phi$, the normalized coordinates $x = \rho_{\mathrm{pol,norm}}$ and $y = \rho_{\mathrm{tor,norm}}$ are defined as

$$
x^2 = \frac{\psi - \psi_{\mathrm{axis}}}
             {\psi_{\mathrm{boundary}} - \psi_{\mathrm{axis}}},
\qquad
y^2 = \frac{\Phi_E(\psi) - \Phi_{\mathrm{axis}}}
             {\Phi_{\mathrm{boundary}} - \Phi_{\mathrm{axis}}}.
$$

Both coordinates are 0 at the magnetic axis, and 1 at the boundary. Assuming nonzero denominators and nonnegative ratios, these relations define an equilibrium-dependent coordinate transformation $y = f_E(x)$. If $f_E$ is continuous and strictly increasing on $[0,1]$, it is invertible, thus

$$
T_{\mathrm{tor}}(y) = T_{\mathrm{pol}}\left(f_E^{-1}(y)\right).
$$

In general $f_E$ is not affine. In practice (i.e. given data stored as finite points in an `IDS` field), an equilibrium provides discrete pairs $(x_i, y_i)$, and a numerical implementation may interpolate between them. For each segment with $x_i < x_{i+1}$ and $y_i < y_{i+1}$, the approximation is

$$
t = \frac{x - x_i}{x_{i+1} - x_i},
\qquad
\widehat f_i(x) = (1-t)y_i + t y_{i+1}.
$$

If the endpoint values $T_i$ and $T_{i+1}$ agree in both coordinates, the linear interpolants are invariant under the transformation:

$$
\widehat T_{\mathrm{tor},i}\left(\widehat f_i(x)\right)
= (1-t)T_i + tT_{i+1}
= \widehat T_{\mathrm{pol},i}(x).
$$

This is a property of the piecewise-affine approximation and is not in general preserved under an exact nonlinear transformation $f_E$.

### What is proved in Lean

[ProfileTransform.lean](Lean4IMAS/Transformations/ProfileTransform.lean) proves for each segment that the affine interpolation is invertible and preserves the interpolated temperature.

[Certificate.lean](Lean4IMAS/Transformations/Certificate.lean) applies these results to one certified, synthetic `core_profiles/profiles_1d` record. It (exactly!) converts the `Float` values into rational values, checks the conditions needed by the example and binds two segments to the supplied coordinate and temperature samples. This slice certificate does not check the enclosing IDS's root-level time constraints.

The example assumes the supplied poloidal and toroidal coordinates correspond, i.e. does not derive or verify their relationship from an `equilibrium` IDS. A floating-point proof (rather than one using rational arithmetic) is feasible but would require more assumptions about bounds on the inputs and intermediate operations.

## IMAS-Validator integration

Executable Lean checks can be called from Python and used in an [IMAS-Validator](https://github.com/iterorganization/IMAS-Validator) rule. The [regridding notebook](notebooks/regrid_demo.ipynb) demonstrates this with two synthetic `core_profiles` IDSs. It checks the target electron temperatures against the source's piecewise-linear interpolant, using `rho_tor_norm` for both grids.

- **[RegridSpec.lean](Lean4IMAS/Checks/RegridSpec.lean)** contains the proposition to audit, `RegridsWithinTolerance`, and its supporting definitions. It requires the same finite time for both slices, matching arrays of finite radii and temperatures, a nonnegative tolerance, at least two strictly increasing source radii and at least one target sample. Every target sample must be bracketed by adjacent source radii and agree with their linear interpolant within the absolute tolerance in eV.
- **[RegridCheck.lean](Lean4IMAS/Checks/RegridCheck.lean)** implements the executable check. Its `check_sound` theorem proves that whenever `check` succeeds, `RegridsWithinTolerance` holds for the supplied records. Lean checks this proof during the build, and the executable evaluates the check on an arbitrary pair of profiles.
- **[RegridMain.lean](Lean4IMAS/Checks/RegridMain.lean)** reads a JSON request, constructs the selected fields of the generated Lean records, calls the checker and returns a verdict and message.
- **[lean4imas.py](lean4imas.py)** wraps that executable as `check_regrid`. It selects the slices, resolves their time coordinates and transfers the original binary64 values. The checker interprets finite floats as exact rational numbers through [ExactFloat.lean](Lean4IMAS/ExactFloat.lean).

To install the notebook dependencies in a local environment, run the following from the repository root.

```sh
python3 -m venv .venv
.venv/bin/python -m pip install "imas-python==2.3.0" "imas-validator @ git+https://github.com/iterorganization/IMAS-Validator.git@52164a5832547c31bef613d379833cab700fb6ee" ipykernel
lake build lean4imas-regrid
```

The IMAS-Validator revision is pinned to the version tested with IMAS-Python 2.3.0. The PyPI release 1.0.0 calls an API that IMAS-Python 2.3.0 removed. Select `.venv/bin/python` as the notebook kernel. Its setup cell finds the repository root and makes the Python adapter importable.

The Python function accepts in-memory IDSs. Given `source` and `target` records, a test can check selected slices directly.

```python
from lean4imas import check_regrid

result = check_regrid(source, target, tolerance_ev=0.1)
assert result.passed, result.message
```

Both slice indices default to 0 and can be selected with `source_slice` and `target_slice`. Applying the theorem to the original IDSs relies on faithful data transfer through the Python adapter and JSON interface, and on the Lean compiler and runtime.

For the IMAS-Validator example, the notebook writes the IDSs to HDF5 entries, displays the full Python rule and saves that rule to a temporary ruleset directory. The runner supplies `core_profiles:1` as the target. The rule loads `core_profiles:0` from the entry named by `LEAN4IMAS_SOURCE_URI`, calls `check_regrid` and records `assert result.passed, result.message` in the validation report. The rule checks slice 0 with a 0.1 eV tolerance.

This source-loading step accommodates IMAS-Validator's result collector, which requires distinct IDS names for a rule with multiple IDS arguments. The notebook runs both a correctly interpolated profile and a profile with an altered final temperature, showing the passing and failing results.
