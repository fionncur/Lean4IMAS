import Lean4IMAS.Generated.core_profiles
import Lean4IMAS.ExactFloat
import Lean4IMAS.LinearInterpolation

/- Specification of the electron-temperature regridding check.
   Start with RegridsWithinTolerance, then read the definitions it uses.
   RegridCheck.lean implements the check and proves check_sound. -/
namespace RegridCheck

open ProfileTransform (blend exactFloat exactValues)

abbrev Slice := IMAS.«core_profiles/profiles_1d»

structure Sample where
  radius : Rat
  temperature : Rat

def sliceTime (slice : Slice) : Option Rat :=
  slice.time.bind (fun time => exactFloat time.value)

/-- Every sample corresponds to the exact stored values at that index in both arrays. -/
def SamplesOf (slice : Slice) (samples : List Sample) : Prop :=
  exactValues slice.grid.rho_tor_norm = samples.map (fun s => some s.radius) ∧
  exactValues slice.electrons.temperature = samples.map (fun s => some s.temperature)

def linearTemperature (left right : Sample) (radius : Rat) : Rat :=
  blend left.temperature right.temperature ((radius - left.radius) / (right.radius - left.radius))

/-- A target sample has an adjacent source interval that brackets it, and its
    temperature is within the absolute tolerance in eV of the linear interpolant. -/
def MatchesInterpolant (source : List Sample) (tolerance : Rat) (point : Sample) : Prop :=
  ∃ before left right after,
    source = before ++ left :: right :: after ∧
    left.radius ≤ point.radius ∧ point.radius ≤ right.radius ∧
    (point.temperature - linearTemperature left right point.radius).abs ≤ tolerance

/-- A claim about the electron temperatures on the target's stored rho_tor_norm
    grid, relative to the source's piecewise-linear interpolant at the same time. -/
def RegridsWithinTolerance (source target : Slice) (tolerance : Rat) : Prop :=
  ∃ time sourceSamples targetSamples,
    sliceTime source = some time ∧ sliceTime target = some time ∧
    SamplesOf source sourceSamples ∧ SamplesOf target targetSamples ∧
    0 ≤ tolerance ∧ 2 ≤ sourceSamples.length ∧ targetSamples ≠ [] ∧
    sourceSamples.Pairwise (fun left right => left.radius < right.radius) ∧
    ∀ point ∈ targetSamples, MatchesInterpolant sourceSamples tolerance point

end RegridCheck
