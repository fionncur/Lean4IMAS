import Lean4IMAS.Checks.RegridSpec

namespace RegridCheck

open ProfileTransform (exactValues)

-- Pair the arrays without dropping trailing values or non-finite entries.
private def pairSamples : List (Option Rat) → List (Option Rat) → Option (List Sample)
  | [], [] => some []
  | some r :: rs, some t :: ts => (pairSamples rs ts).map (fun rest => ⟨r, t⟩ :: rest)
  | _, _ => none

private theorem pairSamples_sound (rs ts : List (Option Rat)) (samples : List Sample)
    (h : pairSamples rs ts = some samples) :
    rs = samples.map (fun s => some s.radius) ∧
    ts = samples.map (fun s => some s.temperature) := by
  induction rs generalizing ts samples with
  | nil =>
    cases ts with
    | nil =>
      simp [pairSamples] at h
      subst samples
      simp
    | cons t ts => simp [pairSamples] at h
  | cons r rs ih =>
    cases ts with
    | nil => cases r <;> simp [pairSamples] at h
    | cons t ts =>
      cases r with
      | none => simp [pairSamples] at h
      | some r =>
        cases t with
        | none => simp [pairSamples] at h
        | some t =>
          cases tail : pairSamples rs ts with
          | none => simp [pairSamples, tail] at h
          | some rest =>
            simp [pairSamples, tail] at h
            subst samples
            obtain ⟨hr, ht⟩ := ih ts rest tail
            simp [hr, ht]

private def readSamples (slice : Slice) : Option (List Sample) :=
  pairSamples (exactValues slice.grid.rho_tor_norm) (exactValues slice.electrons.temperature)

-- Checking adjacent radii is sufficient because strict order is transitive.
private def increasing : List Sample → Bool
  | a :: b :: rest => decide (a.radius < b.radius) && increasing (b :: rest)
  | _ => true

private theorem increasing_sound : ∀ (samples : List Sample), increasing samples = true →
    samples.Pairwise (fun left right => left.radius < right.radius)
  | [], _ => .nil
  | [a], _ => by simp
  | a :: b :: rest, h => by
    have ⟨ab, ordered⟩ := Bool.and_eq_true_iff.mp h
    have tail := increasing_sound (b :: rest) ordered
    apply List.pairwise_cons.mpr
    refine ⟨?_, tail⟩
    intro c hc
    rcases List.mem_cons.mp hc with rfl | hc
    · exact of_decide_eq_true ab
    · exact Std.lt_trans (of_decide_eq_true ab) (List.rel_of_pairwise_cons tail hc)

-- On an increasing grid, stop at the first interval with a high enough right endpoint.
private def findInterval (radius : Rat) : List Sample → Option (Sample × Sample)
  | left :: right :: rest =>
    if radius ≤ right.radius then some (left, right) else findInterval radius (right :: rest)
  | _ => none

private theorem findInterval_sound (radius : Rat) (left right : Sample) :
    ∀ source, findInterval radius source = some (left, right) →
      ∃ before after, source = before ++ left :: right :: after ∧ radius ≤ right.radius
  | [], h => by simp [findInterval] at h
  | [_], h => by simp [findInterval] at h
  | a :: b :: rest, h => by
    by_cases hb : radius ≤ b.radius
    · simp [findInterval, hb] at h
      obtain ⟨rfl, rfl⟩ := h
      exact ⟨[], rest, rfl, hb⟩
    · have hTail : findInterval radius (b :: rest) = some (left, right) := by
        simpa [findInterval, hb] using h
      obtain ⟨before, after, eq, hr⟩ := findInterval_sound radius left right (b :: rest) hTail
      exact ⟨a :: before, after, congrArg (a :: ·) eq, hr⟩

private def checkPoint (source : List Sample) (tolerance : Rat) (point : Sample) : Bool :=
  match findInterval point.radius source with
  | none => false
  | some (left, right) =>
    decide (left.radius ≤ point.radius ∧
      (point.temperature - linearTemperature left right point.radius).abs ≤ tolerance)

private theorem checkPoint_sound (source : List Sample) (tolerance : Rat) (point : Sample)
    (h : checkPoint source tolerance point = true) :
    MatchesInterpolant source tolerance point := by
  cases interval : findInterval point.radius source with
  | none => simp [checkPoint, interval] at h
  | some endpoints =>
    obtain ⟨left, right⟩ := endpoints
    have ⟨hl, err⟩ : left.radius ≤ point.radius ∧
        (point.temperature - linearTemperature left right point.radius).abs ≤ tolerance := by
      simpa [checkPoint, interval] using h
    obtain ⟨before, after, adjacent, hr⟩ := findInterval_sound point.radius left right source interval
    exact ⟨before, left, right, after, adjacent, hl, hr, err⟩

private def checkSamples (source target : List Sample) (tolerance : Rat) : Except String Unit :=
  if source.length < 2 then .error "The source needs at least two samples."
  else if increasing source = false then .error "The source radii must be strictly increasing."
  else if target = [] then .error "The target needs at least one sample."
  else
    match target.findIdx? (fun point => !checkPoint source tolerance point) with
    | some index =>
      .error s!"Target sample {index} is outside the source grid or exceeds the temperature tolerance."
    | none => .ok ()

private theorem checkSamples_sound (source target : List Sample) (tolerance : Rat)
    (h : checkSamples source target tolerance = .ok ()) :
    2 ≤ source.length ∧ target ≠ [] ∧ source.Pairwise (fun a b => a.radius < b.radius) ∧
    ∀ point ∈ target, MatchesInterpolant source tolerance point := by
  unfold checkSamples at h
  split at h
  · contradiction
  next size =>
    split at h
    · contradiction
    next ordered =>
      split at h
      · contradiction
      next nonempty =>
        split at h
        · contradiction
        next allPoints =>
          refine ⟨Nat.le_of_not_gt size, nonempty,
            increasing_sound source (by simpa using ordered), ?_⟩
          intro point member
          apply checkPoint_sound source tolerance point
          simpa using List.findIdx?_eq_none_iff.mp allPoints point member

/-- The runnable check on the two decoded profile slices. The importer resolves
    their time coordinates before constructing the records passed here. -/
def check (source target : Slice) (tolerance : Rat) : Except String Unit :=
  if tolerance < 0 then .error "The temperature tolerance must be nonnegative."
  else
    match sliceTime source, sliceTime target with
    | some sourceTime, some targetTime =>
      if sourceTime = targetTime then
        match readSamples source, readSamples target with
        | some sourceSamples, some targetSamples => checkSamples sourceSamples targetSamples tolerance
        | _, _ => .error "Each profile needs equal numbers of finite radii and temperatures."
      else .error "The two slices must have the same time."
    | _, _ => .error "Both slices need a finite time."

/-- Acceptance of the executable check entails the mathematical claim for the
    supplied records, including coverage of every stored target sample. -/
theorem check_sound (source target : Slice) (tolerance : Rat)
    (h : check source target tolerance = .ok ()) :
    RegridsWithinTolerance source target tolerance := by
  unfold check at h
  split at h
  · contradiction
  next tol =>
    split at h
    next sourceTime targetTime hs ht =>
      split at h
      next sameTime =>
        subst targetTime
        split at h
        next src dst hsamples htarget =>
          have hsrc : SamplesOf source src := pairSamples_sound _ _ _ hsamples
          have hdst : SamplesOf target dst := pairSamples_sound _ _ _ htarget
          obtain ⟨size, nonempty, ordered, points⟩ := checkSamples_sound src dst tolerance h
          exact ⟨sourceTime, src, dst, hs, ht, hsrc, hdst,
            Rat.not_lt.mp tol, size, nonempty, ordered, points⟩
        · contradiction
      · contradiction
    · contradiction

end RegridCheck
