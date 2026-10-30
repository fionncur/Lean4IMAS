import Std

namespace IMAS

-- A unit tag preserves the DD spelling
abbrev Unit := String

structure Quantity (unit : Unit) (α : Type := Float) where
  value : α

instance [Inhabited α] : Inhabited (Quantity unit α) := ⟨⟨default⟩⟩

-- Rectangular, row-major storage. The generated storage predicate checks that
-- data.size = rows * cols, leaving malformed input representable as raw data.
structure Matrix (α : Type) where
  rows : Nat
  cols : Nat
  data : Array α
  deriving Inhabited

def Matrix.storageValid (matrix : Matrix α) : Bool :=
  matrix.data.size == matrix.rows * matrix.cols

-- For a filled array at least one coordinate is filled, and every filled
-- alternative has the same length as the array's dimension.
-- https://imas-python.readthedocs.io/en/stable/validation.html#validate-coordinates
def coordinateSizesMatch (size : Nat) (coordinates : List Nat) : Bool :=
  coordinates.any (fun n => n != 0) &&
    coordinates.all (fun n => n == 0 || n == size)

/-- Pair any raw value with evidence for a chosen predicate. Different
    applications can certify the same record against different predicates. -/
abbrev Certified (α : Type) (valid : α → Prop) := { value : α // valid value }

end IMAS
