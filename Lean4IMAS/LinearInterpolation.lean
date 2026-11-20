import Init.Data.Rat.Basic

namespace ProfileTransform

/-- Exact linear interpolation between `a` and `b` with weight `t`. -/
def blend (a b t : Rat) : Rat := (1 - t) * a + t * b

end ProfileTransform
