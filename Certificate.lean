import generated.core_profiles
import ProfileTransform

/- The source data uses the generated (generated/core_profiles.lean) Float records.
   The certificate interprets their values (exactly) as rationals, then uses the
   results from ProfileTransform.lean. So this formalization does not correspond to any
   "actual" implemented transformation of IMAS data. Floating point implementation is
   feasible, but would just require results about equality to some bound ≤ ε, which
   is not material to this proof of concept. -/
namespace ProfileTransform

-- Interpret the binary Float as an exact rational number for the proofs below.
-- `some` contains the result; `none` rejects infinity and NaN. Both signed
-- zeroes represent rational 0.
def exactFloat (x : Float) : Option Rat :=
  match x.toModel.unpack with
  | .zero _ => some 0
  | .finite sign mantissa exponent _ =>
      let signed : Rat := match sign with
        | .positive => mantissa
        | .negative => -(mantissa : Rat)
      some (if exponent ≥ 0 then signed * (2 ^ exponent.toNat : Nat)
        else signed / (2 ^ (-exponent).toNat : Nat))
  | _ => none

-- Apply exactFloat to each element of a unit-tagged IDS array in order.
def exactValues {unit : IMAS.Unit} (xs : Array (IMAS.Quantity unit)) : List (Option Rat) :=
  xs.toList.map (fun q => exactFloat q.value)

/-- A certificate is attached to one actual generated profiles_1d record.
    It contains the exact rational values and proofs of the conditions used by
    the segment proofs. Constructing a Certificate requires supplying each proof. -/
structure Certificate (source : IMAS.Certified IMAS.«core_profiles/profiles_1d»
    IMAS.«core_profiles/profiles_1d».isValid) where
  rho_pol_norm : List Rat
  rho_tor_norm : List Rat
  temperature : List Rat
  psi : List Rat
  psi_magnetic_axis : Rat
  psi_boundary : Rat
  time : Rat
  -- These equalities tie every rational value back to its stored Float.
  -- Every conversion must return `some`, so NaN and infinity are excluded.
  source_pol : exactValues source.val.grid.rho_pol_norm = rho_pol_norm.map some
  source_tor : exactValues source.val.grid.rho_tor_norm = rho_tor_norm.map some
  source_temperature : exactValues source.val.electrons.temperature = temperature.map some
  source_psi : exactValues source.val.grid.psi = psi.map some
  source_axis : source.val.grid.psi_magnetic_axis.bind (fun q => exactFloat q.value) = some psi_magnetic_axis
  source_boundary : source.val.grid.psi_boundary.bind (fun q => exactFloat q.value) = some psi_boundary
  source_time : source.val.time.bind (fun q => exactFloat q.value) = some time
  -- The remaining fields are proof obligations for this example.
  validity : source.val.electrons.temperature_validity = some 0 ∨ source.val.electrons.temperature_validity = some 1
  temperature_nonempty : temperature ≠ []
  psi_nonempty : psi ≠ []
  at_least_two : 2 ≤ rho_pol_norm.length
  pol_increasing : rho_pol_norm.Pairwise (· < ·)
  tor_increasing : rho_tor_norm.Pairwise (· < ·)
  pol_endpoints : rho_pol_norm.head? = some 0 ∧ rho_pol_norm.getLast? = some 1
  tor_endpoints : rho_tor_norm.head? = some 0 ∧ rho_tor_norm.getLast? = some 1
  nonnegative_temperature : ∀ t ∈ temperature, 0 ≤ t
  nondegenerate_flux : psi_boundary ≠ psi_magnetic_axis
  -- rho_pol_norm² = (psi - psi_axis) / (psi_boundary - psi_axis).
  -- The generated coordinate constraints ensure zip cannot hide extra samples.
  poloidal_normalization : ∀ pair ∈ psi.zip rho_pol_norm,
    0 ≤ pair.2 ∧ pair.2 * pair.2 * (psi_boundary - psi_magnetic_axis) = pair.1 - psi_magnetic_axis

/-- A segment anchored to samples `index` and `index + 1` of the certified data.
    The temperature proofs bind its interpolation endpoints to those same samples. -/
structure CertifiedSegment {source} (c : Certificate source) where
  affine : Segment
  index : Nat
  temperature_lo : Rat
  temperature_hi : Rat
  lower_coordinates : c.rho_pol_norm[index]? = some affine.pol.lo ∧
    c.rho_tor_norm[index]? = some affine.tor.lo
  upper_coordinates : c.rho_pol_norm[index + 1]? = some affine.pol.hi ∧
    c.rho_tor_norm[index + 1]? = some affine.tor.hi
  lower_temperature : c.temperature[index]? = some temperature_lo
  upper_temperature : c.temperature[index + 1]? = some temperature_hi

-- Apply the general affine proofs to a segment tied to this certificate.
-- These hold for every point within that segment, not just the example below.
theorem certificate_roundtrip {source} {c : Certificate source} (s : CertifiedSegment c)
    (x : Point .pol s.affine.pol) : inverse s.affine (forward s.affine x) = x :=
  inverse_forward s.affine x

theorem certificate_temperature {source} {c : Certificate source} (s : CertifiedSegment c)
    (x : Point .pol s.affine.pol) :
    blend s.temperature_lo s.temperature_hi (weight s.affine.tor (forward s.affine x).value) =
      blend s.temperature_lo s.temperature_hi (weight s.affine.pol x.value) :=
  temperature_preserved s.affine s.temperature_lo s.temperature_hi x

-- One example dataset, using the actual DD-generated types. All numbers below
-- are exactly representable in binary64. Unused IDS fields keep empty defaults.
def example_data : IMAS.«core_profiles» := {
  ids_properties := { homogeneous_time := some 1 }
  time := #[⟨1.25⟩]
  profiles_1d := #[{
    time := some ⟨1.25⟩
    grid := {
      rho_pol_norm := #[⟨0⟩, ⟨0.5⟩, ⟨1⟩]
      rho_tor_norm := #[⟨0⟩, ⟨0.25⟩, ⟨1⟩]
      psi := #[⟨2⟩, ⟨2.75⟩, ⟨5⟩]
      psi_magnetic_axis := some ⟨2⟩
      psi_boundary := some ⟨5⟩
    }
    electrons := {
      temperature := #[⟨2000⟩, ⟨1500⟩, ⟨500⟩]
      temperature_validity := some 0
    }
  }]
}

-- Select the first slice and prove that index 0 exists. The certificate below
-- refers to that slice of example_data.
abbrev example_slice := example_data.profiles_1d[0]'(by decide +kernel)

-- Certify the generated validity predicate once for this slice.
def certified_example_slice : IMAS.Certified IMAS.«core_profiles/profiles_1d»
    IMAS.«core_profiles/profiles_1d».isValid :=
  ⟨example_slice, by decide +kernel⟩

-- These lists contain the exact rational values of the stored Floats.
-- The equalities below prove that they match the original data.
def example_certificate : Certificate certified_example_slice where
  rho_pol_norm := [0, 1/2, 1]
  rho_tor_norm := [0, 1/4, 1]
  temperature := [2000, 1500, 500]
  psi := [2, 11/4, 5]
  psi_magnetic_axis := 2
  psi_boundary := 5
  time := 5/4
  source_pol := by decide +kernel
  source_tor := by decide +kernel
  source_temperature := by decide +kernel
  source_psi := by decide +kernel
  source_axis := by decide +kernel
  source_boundary := by decide +kernel
  source_time := by decide +kernel
  validity := by decide +kernel
  temperature_nonempty := by decide +kernel
  psi_nonempty := by decide +kernel
  at_least_two := by decide +kernel
  pol_increasing := by decide +kernel
  tor_increasing := by decide +kernel
  pol_endpoints := by decide +kernel
  tor_endpoints := by decide +kernel
  nonnegative_temperature := by decide +kernel
  nondegenerate_flux := by decide +kernel
  poloidal_normalization := by decide +kernel

-- The three sample pairs define two adjacent segments: indices 0→1 and 1→2.
def first_segment : CertifiedSegment example_certificate where
  affine := ⟨⟨0, 1/2, by decide +kernel⟩, ⟨0, 1/4, by decide +kernel⟩⟩
  index := 0
  temperature_lo := 2000
  temperature_hi := 1500
  lower_coordinates := by decide +kernel
  upper_coordinates := by decide +kernel
  lower_temperature := by decide +kernel
  upper_temperature := by decide +kernel

def second_segment : CertifiedSegment example_certificate where
  affine := ⟨⟨1/2, 1, by decide +kernel⟩, ⟨1/4, 1, by decide +kernel⟩⟩
  index := 1
  temperature_lo := 1500
  temperature_hi := 500
  lower_coordinates := by decide +kernel
  upper_coordinates := by decide +kernel
  lower_temperature := by decide +kernel
  upper_temperature := by decide +kernel

-- An interior point of the first segment: poloidal 1/4 maps to toroidal 1/8.
def query : Point .pol first_segment.affine.pol :=
  ⟨1/4, by decide +kernel, by decide +kernel⟩

-- Check that the two segments share the middle coordinate and temperature.
theorem shared_knot :
    first_segment.affine.pol.hi = second_segment.affine.pol.lo ∧
    first_segment.affine.tor.hi = second_segment.affine.tor.lo ∧
    first_segment.temperature_hi = second_segment.temperature_lo := by decide +kernel

theorem query_coordinate : (forward first_segment.affine query).value = 1/8 := by decide +kernel
theorem query_temperature :
    blend first_segment.temperature_lo first_segment.temperature_hi
      (weight first_segment.affine.tor (forward first_segment.affine query).value) = 1750 := by
  decide +kernel

-- Specialize the general round-trip theorem to each of this dataset's pieces.
theorem first_roundtrip (x : Point .pol first_segment.affine.pol) :
    inverse first_segment.affine (forward first_segment.affine x) = x :=
  certificate_roundtrip first_segment x

theorem second_roundtrip (x : Point .pol second_segment.affine.pol) :
    inverse second_segment.affine (forward second_segment.affine x) = x :=
  certificate_roundtrip second_segment x

-- Report proof dependencies, the supplied toroidal coordinates and temperatures,
-- and the example query's transformed coordinate.
#print axioms example_certificate
#print axioms certificate_roundtrip
#print axioms certificate_temperature
#eval example_certificate.rho_tor_norm
#eval example_certificate.temperature
#eval (forward first_segment.affine query).value

end ProfileTransform
