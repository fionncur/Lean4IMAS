import Lean4IMAS.Validation

namespace ProfileTransform

-- Interpret the binary Float as an exact rational number. Both signed zeroes
-- represent rational 0, while NaN and infinities have no rational value.
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

def exactValues {unit : IMAS.Unit} (xs : Array (IMAS.Quantity unit)) : List (Option Rat) :=
  xs.toList.map (fun q => exactFloat q.value)

end ProfileTransform
