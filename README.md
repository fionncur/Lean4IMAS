# Lean4IMAS - Automatic formalization of IMAS Data-Dictionary IDSs 

This project is a proof of concept to demonstrate the formalization of the IMAS Data Dictionary into Lean 4 records, to allow formal certificates for the validation of data structures and transformations of IMAS data. The current focus is on the `core_profiles` IDS. 

The generator `generate_core_profiles.py` reads the expanded Data Dictionary XML provided by IMAS-Python and produces Lean records that retain the `core_profiles` hierarchy and field types. The project also includes an example certificate for a temperature profile, using an idealized piecewise-affine mapping between poloidal and toroidal coordinates.

A primary motivation for the IMAS Data Dictionary is to support interoperability between plasma physics and fusion codes by providing a shared, machine-readable description of their inputs and outputs. The same IDS can also represent experimental data from different devices, facilitating the comparison (and compilation) of results. Formalizing these structures in Lean provides a foundation for *stating* and *proving properties* of IMAS data, and especially of *transformations* applied to it, noting that the numerical implementation of such transformations is the substance of a simulation code. 

Since IMAS can represent both simulation and experimental data in the same structures, formalization could provide a common foundation for the systematic comparison of simulation and experimental data; for example, through a formally specified and verified forward diagnostic model that maps simulation quantities to experimental quantities.

## `core_profiles` → Lean

The generator can be run as follows:

```sh
python3 generate_core_profiles.py --check
```

This outputs [generated/core_profiles.lean](generated/core_profiles.lean), a Lean file containing **890 fields** for every node in the `core_profiles` IDS, preserving the hierarchy, field types and unit tags, and including error fields and `ids_properties`. Each record is named directly by its DD path. For example, `core_profiles/profiles_1d/electrons` becomes `IMAS.«core_profiles/profiles_1d/electrons»`. The quotes make the path a single Lean name, while fields retain their original names and use normal dot access.

The records also implement partial *validation* of the data structure, currently restricted to just the [coordinate validation](https://imas-python.readthedocs.io/en/stable/validation.html#validate-coordinates). In IMAS-Python, these (and other relationships!) are checked by the `.validate()` method. This enforces certain constraints on the population of valid records with coordinate arrays and their dependent arrays. For `core_profiles`, DD 4.1.1 and IMAS-Python 2.3.0 we have implemented that:

- Coordinate arrays must match populated data arrays in size, including each dimension of a matrix.
- Alternative coordinates and `coordinate*_same_as` size relationships.
- Empty dependent arrays don’t require filled coordinates.
- For dynamic arrays of structures such as `profiles_1d`: homogeneous time uses the root time array; heterogeneous time requires a time in each slice.

We have not yet implemented:

- Checking that `ids_properties/homogeneous_time` is a valid time mode.
- Rejecting all populated time-dependent fields when the time mode is independent.
- IMAS-Python’s empty-sentinel handling: Lean uses `none` for missing scalars, but there is no importer yet to translate the sentinel values.
- Exact equivalence for every coordinate case and error-handling path has not been established, only representative cases have been compared.

As an example excerpt of a field, the `core_profiles/profiles_1d(itime)/electrons` node looks like:

```lean
structure «core_profiles/profiles_1d/electrons» where
  temperature : Array (Quantity .eV) := default
  temperature_error_upper : Array (Quantity .eV) := default
  temperature_error_lower : Array (Quantity .eV) := default
  temperature_validity : Option Int32 := default
  ...
```

Here, the coordinate size constraints are checked when it is placed in an enclosing `profiles_1d` record. The standalone electrons record cannot check the sibling grid.

Some conventions for the translation of the data structure to Lean are that:

- Floating-point values use `Float`; integers use `Int32`; text uses `String`.
- Unfilled scalars use `Option`: `none` means missing, `some value` means present.
- One-dimensional arrays use `Array`; two-dimensional arrays use a small rectangular `Matrix` with row-major storage and a storage-size proof (general N-d arrays not yet implemented).
- Units are simple tags with the original DD spelling, such as `.s`, `.Wb` and `.«m^-3»`. 
- Fields default to empty values, so partial records are easy to construct.

Here is an example of assigning data to a record:

```lean
def electrons : IMAS.«core_profiles/profiles_1d/electrons» := {
  temperature := #[⟨1200.0⟩, ⟨1500.0⟩]
  temperature_validity := some 0
}
```