import Std

/- Exact affine-segment mathematics. These operations use *rational values*. -/
namespace ProfileTransform

-- These tags distinguish poloidal and toroidal coordinates in Lean's types.
inductive Coord where
  | pol | tor
  deriving DecidableEq

-- A domain is one closed interval. The final field is a proof that its
-- endpoints are strictly increasing -> its width is nonzero.
structure Domain where
  lo : Rat
  hi : Rat
  increasing : lo < hi

-- A point carries both its coordinate tag and proofs that it is in its domain.
-- For example, Point .pol d cannot be passed where Point .tor d is required.
structure Point (coord : Coord) (domain : Domain) where
  value : Rat
  lower : domain.lo ≤ value
  upper : value ≤ domain.hi

-- One pair of corresponding intervals between adjacent coordinate samples.
structure Segment where
  pol : Domain
  tor : Domain

-- The local coordinate of x within an interval.
def weight (d : Domain) (x : Rat) : Rat := (x - d.lo) / (d.hi - d.lo)
-- Linear interpolation.
def blend (a b t : Rat) : Rat := (1 - t) * a + t * b

-- Proof that local coordinate lies in [0,1] if x is in domain.
theorem weight_range (d : Domain) (x : Rat) (hl : d.lo ≤ x) (hu : x ≤ d.hi) :
    0 ≤ weight d x ∧ weight d x ≤ 1 := by
  have hd : 0 < d.hi - d.lo := by have := d.increasing; grind
  have hi : 0 < (d.hi - d.lo)⁻¹ := Rat.inv_pos.mpr hd
  have h₁ := Rat.mul_nonneg (show 0 ≤ x - d.lo by grind)
                           (show 0 ≤ (d.hi - d.lo)⁻¹ by grind)
  have h₂ := Rat.mul_nonneg (show 0 ≤ d.hi - x by grind)
                           (show 0 ≤ (d.hi - d.lo)⁻¹ by grind)
  have hc := Rat.mul_inv_cancel (d.hi - d.lo) (show d.hi - d.lo ≠ 0 by grind)
  unfold weight
  simp only [Rat.div_def]
  grind

-- Proof that interpolated point lies in the interval [a,b]
theorem blend_range (a b t : Rat) (h : a ≤ b) (ht : 0 ≤ t) (ht1 : t ≤ 1) :
    a ≤ blend a b t ∧ blend a b t ≤ b := by
  have h₁ := Rat.mul_nonneg ht (show 0 ≤ b - a by grind)
  have h₂ := Rat.mul_nonneg (show 0 ≤ 1 - t by grind) (show 0 ≤ b - a by grind)
  unfold blend
  grind

-- Converting between a position and its interpolation weight is invertible
-- because Domain requires distinct endpoints.
theorem weight_blend (d : Domain) (t : Rat) :
    weight d (blend d.lo d.hi t) = t := by
  have := d.increasing
  unfold weight blend
  grind

theorem blend_weight (d : Domain) (x : Rat) :
    blend d.lo d.hi (weight d x) = x := by
  have := d.increasing
  unfold weight blend
  grind

-- Keep the same interpolation weight when moving from the poloidal interval
-- to the toroidal interval. The proof fields show the result is in bounds.
def forward (s : Segment) (x : Point .pol s.pol) : Point .tor s.tor :=
  let t := weight s.pol x.value
  let ht := weight_range s.pol x.value x.lower x.upper
  let h := blend_range s.tor.lo s.tor.hi t (by have := s.tor.increasing; grind) ht.1 ht.2
  ⟨blend s.tor.lo s.tor.hi t, h.1, h.2⟩

-- Reverse the same construction: find the toroidal weight and use it in the
-- poloidal interval. These are exact Rat operations, not Float operations.
def inverse (s : Segment) (y : Point .tor s.tor) : Point .pol s.pol :=
  let t := weight s.tor y.value
  let ht := weight_range s.tor y.value y.lower y.upper
  let h := blend_range s.pol.lo s.pol.hi t (by have := s.pol.increasing; grind) ht.1 ht.2
  ⟨blend s.pol.lo s.pol.hi t, h.1, h.2⟩

-- Both directions round-trip for every point in the relevant segment.
-- `simp` applies the two weight/blend identities proved above.
theorem inverse_forward (s : Segment) (x : Point .pol s.pol) :
    inverse s (forward s x) = x := by
  cases x
  simp only [inverse, forward, weight_blend, blend_weight]

theorem forward_inverse (s : Segment) (y : Point .tor s.tor) :
    forward s (inverse s y) = y := by
  cases y
  simp only [inverse, forward, weight_blend, blend_weight]

-- Increasing inputs remain increasing after the coordinate transformation.
theorem forward_strict_mono (s : Segment) (x y : Point .pol s.pol)
    (h : x.value < y.value) : (forward s x).value < (forward s y).value := by
  have hp : 0 < s.pol.hi - s.pol.lo := by have := s.pol.increasing; grind
  have ht : 0 < s.tor.hi - s.tor.lo := by have := s.tor.increasing; grind
  have hi : 0 < (s.pol.hi - s.pol.lo)⁻¹ := Rat.inv_pos.mpr hp
  have hz := Rat.mul_pos (show 0 < y.value - x.value by grind) hi
  have hw := Rat.mul_pos hz ht
  change blend _ _ (weight _ _) < blend _ _ (weight _ _)
  unfold weight blend
  simp only [Rat.div_def]
  grind

-- Interpolation stays between the endpoint values, whichever is larger.
theorem interpolation_hull (a b t : Rat) (ht : 0 ≤ t) (ht1 : t ≤ 1) :
    (a ≤ blend a b t ∧ blend a b t ≤ b) ∨
    (b ≤ blend a b t ∧ blend a b t ≤ a) := by
  by_cases h : a ≤ b
  · exact Or.inl (blend_range a b t h ht ht1)
  · have hba : b ≤ a := by grind
    have hb := blend_range b a (1 - t) hba (by grind) (by grind)
    unfold blend at *
    grind

theorem interpolation_constant (a t : Rat) : blend a a t = a := by unfold blend; grind
theorem interpolation_left (a b : Rat) : blend a b 0 = a := by unfold blend; grind
theorem interpolation_right (a b : Rat) : blend a b 1 = b := by unfold blend; grind

-- Adjacent pieces agree at their shared endpoint.
theorem adjacent_knot (a b c : Rat) : blend a b 1 = blend b c 0 := by
  simp only [interpolation_left, interpolation_right]

/-- Changing coordinates preserves the linear temperature interpolant.
    The two weights are equal because `forward` keeps the position within the
    corresponding interval. `rw` replaces one side using that proven identity. -/
theorem temperature_preserved (s : Segment) (a b : Rat) (x : Point .pol s.pol) :
    blend a b (weight s.tor (forward s x).value) =
      blend a b (weight s.pol x.value) := by
  change blend a b (weight s.tor (blend s.tor.lo s.tor.hi (weight s.pol x.value))) = _
  rw [weight_blend]

#print axioms inverse_forward
#print axioms forward_inverse
#print axioms forward_strict_mono
#print axioms interpolation_hull
#print axioms temperature_preserved

end ProfileTransform
