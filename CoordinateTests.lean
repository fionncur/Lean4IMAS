import generated.core_profiles

-- The populated poloidal coordinate is a valid alternative to rho_tor_norm.
example : IMAS.«core_profiles/profiles_1d» := {
  grid := { rho_pol_norm := #[⟨0⟩, ⟨1⟩], coordinates_valid := by decide }
  electrons := { temperature := #[⟨10⟩, ⟨20⟩] }
  coordinates_valid := by decide
}

-- An empty dependent field does not need to match a populated coordinate.
example : IMAS.«core_profiles/profiles_1d» := {
  grid := { rho_pol_norm := #[⟨0⟩, ⟨1⟩], coordinates_valid := by decide }
  coordinates_valid := by decide
}

-- Lean must reject an incorrectly sized temperature array.
example : True := by
  fail_if_success
    let _bad : IMAS.«core_profiles/profiles_1d» := {
      grid := { rho_pol_norm := #[⟨0⟩, ⟨1⟩], coordinates_valid := by decide }
      electrons := { temperature := #[⟨10⟩, ⟨20⟩, ⟨30⟩] }
      coordinates_valid := by decide
    }
  trivial

-- A populated quantity needs at least one coordinate.
example : True := by
  fail_if_success
    let _bad : IMAS.«core_profiles/profiles_1d» := {
      electrons := { temperature := #[⟨10⟩] }
      coordinates_valid := by decide
    }
  trivial

-- Populated alternative coordinates must agree with each other.
example : True := by
  fail_if_success
    let _bad : IMAS.«core_profiles/profiles_1d/grid» := {
      rho_tor_norm := #[⟨0⟩, ⟨1⟩]
      rho_pol_norm := #[⟨0⟩, ⟨0.5⟩, ⟨1⟩]
      coordinates_valid := by decide
    }
  trivial

-- Error fields have a DD same-size relationship to their source field.
example : IMAS.«core_profiles/profiles_1d/grid» := {
  rho_tor_norm := #[⟨0⟩, ⟨1⟩]
  rho_tor_norm_error_upper := #[⟨0⟩, ⟨0⟩]
  coordinates_valid := by decide
}

example : True := by
  fail_if_success
    let _bad : IMAS.«core_profiles/profiles_1d/grid» := {
      rho_tor_norm := #[⟨0⟩, ⟨1⟩]
      rho_tor_norm_error_upper := #[⟨0⟩]
      coordinates_valid := by decide
    }
  trivial

-- Both matrix dimensions must match the coordinate length.
example : IMAS.«core_profiles/covariance» := {
  rows_uri := #["a", "b"]
  data := ⟨2, 2, #[⟨0⟩, ⟨0⟩, ⟨0⟩, ⟨0⟩], by decide⟩
  coordinates_valid := by decide
}

example : True := by
  fail_if_success
    let _bad : IMAS.«core_profiles/covariance» := {
      rows_uri := #["a", "b"]
      data := ⟨2, 1, #[⟨0⟩, ⟨0⟩], by decide⟩
      coordinates_valid := by decide
    }
  trivial

-- The check also reaches fields inside an array of ion structures.
example : True := by
  fail_if_success
    let _bad : IMAS.«core_profiles/profiles_1d» := {
      grid := { rho_pol_norm := #[⟨0⟩, ⟨1⟩], coordinates_valid := by decide }
      ion := #[{ temperature := #[⟨1⟩] }]
      coordinates_valid := by decide
    }
  trivial

-- Homogeneous time uses root time; heterogeneous time uses each slice's time.
example : True := by
  fail_if_success
    let _bad : IMAS.«core_profiles» := {
      ids_properties := { homogeneous_time := some 1 }
      profiles_1d := #[default]
      coordinates_valid := by decide
    }
  trivial

example : IMAS.«core_profiles» := {
  ids_properties := { homogeneous_time := some 0 }
  profiles_1d := #[{ time := some ⟨1⟩, coordinates_valid := by decide }]
  coordinates_valid := by decide
}

example : True := by
  fail_if_success
    let _bad : IMAS.«core_profiles» := {
      ids_properties := { homogeneous_time := some 0 }
      profiles_1d := #[default]
      coordinates_valid := by decide
    }
  trivial
