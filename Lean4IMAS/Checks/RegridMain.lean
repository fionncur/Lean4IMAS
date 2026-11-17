import Lean
import Lean4IMAS.Checks.RegridCheck

open Lean

-- Python sends each float's 64-bit representation as an integer string.
-- Float.ofBits reconstructs exactly the same stored value in Lean.
private structure SliceInput where
  time : Option UInt64
  rho_tor_norm : Array UInt64
  temperature : Array UInt64
  deriving FromJson

private def SliceInput.toRecord (input : SliceInput) : RegridCheck.Slice := {
  time := input.time.map (fun bits => ⟨Float.ofBits bits⟩)
  grid := { rho_tor_norm := input.rho_tor_norm.map (fun bits => ⟨Float.ofBits bits⟩) }
  electrons := { temperature := input.temperature.map (fun bits => ⟨Float.ofBits bits⟩) }
}

private structure Request where
  source : SliceInput
  target : SliceInput
  tolerance_ev : UInt64
  deriving FromJson

private structure Report where
  passed : Bool
  message : String
  deriving ToJson

private def runCheck (request : Request) : Except String Unit := do
  let some tolerance := ProfileTransform.exactFloat (Float.ofBits request.tolerance_ev)
    | throw "The temperature tolerance must be finite."
  RegridCheck.check request.source.toRecord request.target.toRecord tolerance

def main : IO Unit := do
  let input ← (← IO.getStdin).readToEnd
  let request ← match Json.parse input >>= fromJson? with
    | .ok request => pure request
    | .error reason => throw (IO.userError s!"Invalid regrid request: {reason}")
  let report : Report := match runCheck request with
    | .ok () => ⟨true, "The stored target temperatures agree with the linear interpolant."⟩
    | .error reason => ⟨false, reason⟩
  (← IO.getStdout).putStrLn (toJson report).compress
