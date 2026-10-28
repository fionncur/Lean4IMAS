# Lean4IMAS - Automatic formalization of IMAS Data-Dictionary IDSs 

This project is a proof of concept to demonstrate the formalization of the IMAS Data Dictionary into Lean 4 records, to allow formal certificates for the validation of data structures, and transformations of IMAS data. The current focus is on the `core_profiles` IDS. 

The generator `generate_core_profiles.py` reads the expanded Data Dictionary XML provided by IMAS-Python and produces Lean records that retain the `core_profiles` hierarchy and field
types. The project also includes an example certificate for a temperature profile, using an idealized piecewise-affine mapping between poloidal and toroidal coordinates.