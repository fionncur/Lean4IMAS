# Lean4IMAS - Automatic formalization of IMAS Data-Dictionary IDSs 

This project is a proof of concept to demonstrate the formalization of the IMAS Data Dictionary into Lean 4 records, to allow formal certificates for the validation of data structures and transformations of IMAS data. The current focus is on the `core_profiles` IDS. 

The generator `generate_core_profiles.py` reads the expanded Data Dictionary XML provided by IMAS-Python and produces Lean records that retain the `core_profiles` hierarchy and field
types. The project also includes an example certificate for a temperature profile, using an idealized piecewise-affine mapping between poloidal and toroidal coordinates.

A primary motivation for the IMAS Data Dictionary is to support interoperability between plasma physics and fusion codes by providing a shared, machine-readable description of their inputs and outputs. The same IDS can also represent experimental data from different devices, facilitating the comparison (and compilation) of results. Formalizing these structures in Lean provides a foundation for *stating* and *proving properties* of IMAS data, and especially of *transformations* applied to it, noting that the numerical implementation of such transformations is the substance of a simulation code. 

Since IMAS can represent both simulation and experimental data in the same structures, formalization could provide a common foundation for the systematic comparison of simulation and experimental data; for example, through a formally specified and verified forward diagnostic model that maps simulation quantities to experimental quantities.