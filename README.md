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
- Lean uses `none` for missing scalars. An importer for IMAS data would need to handle empty float/int sentinels. 

As an example excerpt of a field, the `core_profiles/profiles_1d(itime)/electrons` node looks like:

```lean
structure «core_profiles/profiles_1d/electrons» where
  temperature : Array (Quantity .eV) := default
  temperature_error_upper : Array (Quantity .eV) := default
  temperature_error_lower : Array (Quantity .eV) := default
  temperature_validity : Option Int32 := default
  ...
```

Here, the coordinate array sizing constraints are checked when it is enclosed in a `profiles_1d` record. The individual `electrons` record cannot check the grid stored in the sibling node.

Some conventions for the translation of the data structure to Lean are that:

- Floating point values use `Float`, integers use `Int32`, text uses `String`.
- Scalars use `Option`. `none` means missing, `some value` means present.
- One dimensional arrays use `Array`, two-dimensional arrays use `Matrix` (general N-d arrays not yet implemented).
- Units are tags with the original DD spelling, such as `.s`, `.Wb` and `.«m^-3»`. 
- Fields default to empty values (like with IMAS data), so partially filled records are valid.

Here is an example of assigning data to a record:

```lean
def electrons : IMAS.«core_profiles/profiles_1d/electrons» := {
  temperature := #[⟨1200.0⟩, ⟨1500.0⟩]
  temperature_validity := some 0
}
```

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

[ProfileTransform.lean](ProfileTransform.lean) proves for each segment that the affine interpolation is invertible and preserves the interpolated temperature.

[Certificate.lean](Certificate.lean) appies these results to one synthetic `core_profiles/profiles_1d` record. It (exactly!) converts the `Float` values into rational values, checks the conditions needed by the example and binds two segments to the supplied coordinate and temperature samples.

The example assumes the supplied poloidal and toroidal coordinates correspond, i.e. does not derive or verify their relationship from an `equilibrium` IDS. A floating-point proof (rather than one using rational arithmetic) is feasible but would require more assumptions about bounds on the inputs and intermediate operations.
