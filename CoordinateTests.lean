import generated.core_profiles

namespace CoordinateTests

abbrev Slice := IMAS.«core_profiles/profiles_1d»
abbrev Grid := IMAS.«core_profiles/profiles_1d/grid»
abbrev Covariance := IMAS.«core_profiles/covariance»
abbrev IDS := IMAS.«core_profiles»

-- Raw data can be constructed whether or not it passes the checks.
def alternative : Slice := {
  grid := { rho_pol_norm := #[⟨0⟩, ⟨1⟩] }
  electrons := { temperature := #[⟨10⟩, ⟨20⟩] }
}
example : alternative.isValid := by decide +kernel
example : IMAS.Certified Slice IMAS.«core_profiles/profiles_1d».isValid := ⟨alternative, by decide +kernel⟩

-- Application-specific requirements can be added without changing the record.
def HasTemperature (slice : Slice) : Prop := slice.electrons.temperature.size > 0
example : IMAS.Certified Slice (fun slice => slice.isValid ∧ HasTemperature slice) :=
  ⟨alternative, by
    constructor
    · decide +kernel
    · unfold HasTemperature
      decide +kernel⟩

-- An empty dependent field does not need to match a populated coordinate.
def emptyDependent : Slice := { grid := { rho_pol_norm := #[⟨0⟩, ⟨1⟩] } }
example : emptyDependent.isValid := by decide +kernel

def wrongTemperature : Slice := {
  grid := { rho_pol_norm := #[⟨0⟩, ⟨1⟩] }
  electrons := { temperature := #[⟨10⟩, ⟨20⟩, ⟨30⟩] }
}
example : ¬ wrongTemperature.coordinatesValid := by decide +kernel

-- A populated quantity needs a coordinate; populated alternatives must agree.
def missingCoordinate : Slice := { electrons := { temperature := #[⟨10⟩] } }
example : ¬ missingCoordinate.coordinatesValid := by decide +kernel

def disagreeingCoordinates : Grid := {
  rho_tor_norm := #[⟨0⟩, ⟨1⟩]
  rho_pol_norm := #[⟨0⟩, ⟨0.5⟩, ⟨1⟩]
}
example : ¬ disagreeingCoordinates.coordinatesValid := by decide +kernel

-- Error arrays have a same-size relationship to their source field.
def matchingError : Grid := {
  rho_tor_norm := #[⟨0⟩, ⟨1⟩]
  rho_tor_norm_error_upper := #[⟨0⟩, ⟨0⟩]
}
example : matchingError.isValid := by decide +kernel

def wrongError : Grid := {
  rho_tor_norm := #[⟨0⟩, ⟨1⟩]
  rho_tor_norm_error_upper := #[⟨0⟩]
}
example : ¬ wrongError.coordinatesValid := by decide +kernel

-- Both dimensions of a populated matrix must match its coordinates.
def goodMatrix : Covariance := {
  rows_uri := #["a", "b"]
  data := ⟨2, 2, #[⟨0⟩, ⟨0⟩, ⟨0⟩, ⟨0⟩]⟩
}
example : goodMatrix.isValid := by decide +kernel

def wrongMatrixDimension : Covariance := {
  rows_uri := #["a", "b"]
  data := ⟨2, 1, #[⟨0⟩, ⟨0⟩]⟩
}
example : ¬ wrongMatrixDimension.coordinatesValid := by decide +kernel

-- Matrix dimensions are checked for every ion in a structure array.
def goodIonMatrices : IMAS.«core_profiles/profiles_2d» := {
  grid := { dim1 := #[⟨0⟩, ⟨1⟩], dim2 := #[⟨0⟩, ⟨1⟩, ⟨2⟩] }
  ion := #[
    { temperature := ⟨2, 3, #[⟨0⟩, ⟨0⟩, ⟨0⟩, ⟨0⟩, ⟨0⟩, ⟨0⟩]⟩ },
    { temperature := ⟨2, 3, #[⟨0⟩, ⟨0⟩, ⟨0⟩, ⟨0⟩, ⟨0⟩, ⟨0⟩]⟩ }
  ]
}
example : goodIonMatrices.isValid := by decide +kernel

def wrongIonMatrix : IMAS.«core_profiles/profiles_2d» := {
  grid := { dim1 := #[⟨0⟩, ⟨1⟩], dim2 := #[⟨0⟩, ⟨1⟩, ⟨2⟩] }
  ion := #[
    { temperature := ⟨2, 3, #[⟨0⟩, ⟨0⟩, ⟨0⟩, ⟨0⟩, ⟨0⟩, ⟨0⟩]⟩ },
    { temperature := ⟨2, 2, #[⟨0⟩, ⟨0⟩, ⟨0⟩, ⟨0⟩]⟩ }
  ]
}
example : ¬ wrongIonMatrix.coordinatesValid := by decide +kernel

-- Shape/storage agreement was previously enforced by Matrix's proof field.
def wrongMatrixStorage : Covariance := {
  rows_uri := #["a", "b"]
  data := ⟨2, 2, #[⟨0⟩, ⟨0⟩]⟩
}
example : wrongMatrixStorage.coordinatesValid := by decide +kernel
example : ¬ wrongMatrixStorage.storageValid := by decide +kernel
example : ¬ wrongMatrixStorage.isValid := by decide +kernel

-- The check also reaches fields inside an array of ion structures.
def wrongIon : Slice := {
  grid := { rho_pol_norm := #[⟨0⟩, ⟨1⟩] }
  ion := #[{ temperature := #[⟨1⟩] }]
}
example : ¬ wrongIon.coordinatesValid := by decide +kernel

-- Grouped checks must inspect every field and every array element.
def wrongSecondIon : Slice := {
  grid := { rho_pol_norm := #[⟨0⟩, ⟨1⟩] }
  ion := #[{ temperature := #[⟨1⟩, ⟨2⟩] }, { temperature := #[⟨1⟩] }]
}
example : ¬ wrongSecondIon.coordinatesValid := by decide +kernel

def wrongLaterField : Slice := {
  grid := { rho_pol_norm := #[⟨0⟩, ⟨1⟩] }
  q := #[⟨1⟩]
}
example : ¬ wrongLaterField.coordinatesValid := by decide +kernel

-- A malformed matrix is also rejected through an enclosing IDS.
def nestedBadStorage : IDS := {
  covariance := wrongMatrixStorage
}
example : ¬ nestedBadStorage.storageValid := by decide +kernel
example : ¬ nestedBadStorage.isValid := by decide +kernel

-- Storage checks also descend through arrays of structures.
def badArrayElementStorage : IDS := {
  profiles_2d := #[{ grid := { volume_element := ⟨2, 2, #[⟨0⟩]⟩ } }]
}
example : ¬ badArrayElementStorage.storageValid := by decide +kernel

-- Parent validation must include the child's own independent constraints.
def invalidChild : IDS := {
  ids_properties := { homogeneous_time := some 0 }
  profiles_1d := #[{ time := some ⟨1⟩, grid := disagreeingCoordinates }]
}
example : ¬ invalidChild.coordinatesValid := by decide +kernel

-- Homogeneous time uses root time; heterogeneous time uses each slice's time.
def wrongHomogeneous : IDS := {
  ids_properties := { homogeneous_time := some 1 }
  profiles_1d := #[default]
}
example : ¬ wrongHomogeneous.coordinatesValid := by decide +kernel

def homogeneous : IDS := {
  ids_properties := { homogeneous_time := some 1 }
  time := #[⟨1⟩]
  profiles_1d := #[default]
}
example : homogeneous.isValid := by decide +kernel

def heterogeneous : IDS := {
  ids_properties := { homogeneous_time := some 0 }
  profiles_1d := #[{ time := some ⟨1⟩ }]
}
example : heterogeneous.isValid := by decide +kernel

def wrongHeterogeneous : IDS := {
  ids_properties := { homogeneous_time := some 0 }
  profiles_1d := #[default]
}
example : ¬ wrongHeterogeneous.coordinatesValid := by decide +kernel

-- Empty structure arrays do not require a time mode or populated time.
example : (default : IDS).isValid := by decide +kernel

end CoordinateTests
