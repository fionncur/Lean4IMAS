-- Generated from IMAS DD core_profiles. Regenerate rather than editing.
-- Each record is named by its DD path; «...» makes the path one Lean name.
-- Option means a scalar may be missing; Array and Matrix represent arrays.
-- Defaults make it possible to construct a partial IDS without filling every field.
-- Unit tags retain the source XML's spellings.
import IMASValidation

namespace IMAS

-- IMAS-Python skips global_quantities/ion's time-dependent coordinate
-- lookup into profiles_1d/ion (IMAS-4675); it is not enforced here.

structure «core_profiles/ids_properties/occurrence_type» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/ids_properties/version_put» where
  data_dictionary : Option String := default
  access_layer : Option String := default
  access_layer_language : Option String := default
  deriving Inhabited

structure «core_profiles/ids_properties/provenance/node/reference» where
  name : Option String := default
  timestamp : Option String := default
  deriving Inhabited

structure «core_profiles/ids_properties/provenance/node» where
  path : Option String := default
  reference : Array IMAS.«core_profiles/ids_properties/provenance/node/reference» := default
  deriving Inhabited

structure «core_profiles/ids_properties/provenance» where
  node : Array IMAS.«core_profiles/ids_properties/provenance/node» := default
  deriving Inhabited

structure «core_profiles/ids_properties/plugins/node/put_operation/library» where
  name : Option String := default
  description : Option String := default
  commit : Option String := default
  version : Option String := default
  repository : Option String := default
  parameters : Option String := default
  deriving Inhabited

structure «core_profiles/ids_properties/plugins/node/put_operation» where
  name : Option String := default
  description : Option String := default
  commit : Option String := default
  version : Option String := default
  repository : Option String := default
  parameters : Option String := default
  library : Array IMAS.«core_profiles/ids_properties/plugins/node/put_operation/library» := default
  deriving Inhabited

structure «core_profiles/ids_properties/plugins/node/readback/library» where
  name : Option String := default
  description : Option String := default
  commit : Option String := default
  version : Option String := default
  repository : Option String := default
  parameters : Option String := default
  deriving Inhabited

structure «core_profiles/ids_properties/plugins/node/readback» where
  name : Option String := default
  description : Option String := default
  commit : Option String := default
  version : Option String := default
  repository : Option String := default
  parameters : Option String := default
  library : Array IMAS.«core_profiles/ids_properties/plugins/node/readback/library» := default
  deriving Inhabited

structure «core_profiles/ids_properties/plugins/node/get_operation/library» where
  name : Option String := default
  description : Option String := default
  commit : Option String := default
  version : Option String := default
  repository : Option String := default
  parameters : Option String := default
  deriving Inhabited

structure «core_profiles/ids_properties/plugins/node/get_operation» where
  name : Option String := default
  description : Option String := default
  commit : Option String := default
  version : Option String := default
  repository : Option String := default
  parameters : Option String := default
  library : Array IMAS.«core_profiles/ids_properties/plugins/node/get_operation/library» := default
  deriving Inhabited

structure «core_profiles/ids_properties/plugins/node» where
  path : Option String := default
  put_operation : Array IMAS.«core_profiles/ids_properties/plugins/node/put_operation» := default
  readback : Array IMAS.«core_profiles/ids_properties/plugins/node/readback» := default
  get_operation : Array IMAS.«core_profiles/ids_properties/plugins/node/get_operation» := default
  deriving Inhabited

structure «core_profiles/ids_properties/plugins/infrastructure_put» where
  name : Option String := default
  description : Option String := default
  commit : Option String := default
  version : Option String := default
  repository : Option String := default
  deriving Inhabited

structure «core_profiles/ids_properties/plugins/infrastructure_get» where
  name : Option String := default
  description : Option String := default
  commit : Option String := default
  version : Option String := default
  repository : Option String := default
  deriving Inhabited

structure «core_profiles/ids_properties/plugins» where
  node : Array IMAS.«core_profiles/ids_properties/plugins/node» := default
  infrastructure_put : IMAS.«core_profiles/ids_properties/plugins/infrastructure_put» := default
  infrastructure_get : IMAS.«core_profiles/ids_properties/plugins/infrastructure_get» := default
  deriving Inhabited

structure «core_profiles/ids_properties» where
  comment : Option String := default
  name : Option String := default
  homogeneous_time : Option Int32 := default
  occurrence_type : IMAS.«core_profiles/ids_properties/occurrence_type» := default
  provider : Option String := default
  creation_date : Option String := default
  version_put : IMAS.«core_profiles/ids_properties/version_put» := default
  provenance : IMAS.«core_profiles/ids_properties/provenance» := default
  plugins : IMAS.«core_profiles/ids_properties/plugins» := default
  deriving Inhabited

structure «core_profiles/profiles_1d/grid» where
  rho_tor_norm : Array (Quantity "1") := default
  rho_tor_norm_error_upper : Array (Quantity "1") := default
  rho_tor_norm_error_lower : Array (Quantity "1") := default
  rho_tor : Array (Quantity "m") := default
  rho_tor_error_upper : Array (Quantity "m") := default
  rho_tor_error_lower : Array (Quantity "m") := default
  rho_pol_norm : Array (Quantity "1") := default
  rho_pol_norm_error_upper : Array (Quantity "1") := default
  rho_pol_norm_error_lower : Array (Quantity "1") := default
  psi : Array (Quantity "Wb") := default
  psi_error_upper : Array (Quantity "Wb") := default
  psi_error_lower : Array (Quantity "Wb") := default
  volume : Array (Quantity "m^3") := default
  volume_error_upper : Array (Quantity "m^3") := default
  volume_error_lower : Array (Quantity "m^3") := default
  area : Array (Quantity "m^2") := default
  area_error_upper : Array (Quantity "m^2") := default
  area_error_lower : Array (Quantity "m^2") := default
  surface : Array (Quantity "m^2") := default
  surface_error_upper : Array (Quantity "m^2") := default
  surface_error_lower : Array (Quantity "m^2") := default
  psi_magnetic_axis : Option (Quantity "Wb") := default
  psi_magnetic_axis_error_upper : Option (Quantity "Wb") := default
  psi_magnetic_axis_error_lower : Option (Quantity "Wb") := default
  psi_boundary : Option (Quantity "Wb") := default
  psi_boundary_error_upper : Option (Quantity "Wb") := default
  psi_boundary_error_lower : Option (Quantity "Wb") := default
  deriving Inhabited

structure «core_profiles/profiles_1d/electrons/temperature_fit/time_measurement_slice_method» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/electrons/temperature_fit» where
  measured : Array (Quantity "mixed") := default
  measured_error_upper : Array (Quantity "mixed") := default
  measured_error_lower : Array (Quantity "mixed") := default
  source : Array String := default
  time_measurement : Array (Quantity "s") := default
  time_measurement_error_upper : Array (Quantity "s") := default
  time_measurement_error_lower : Array (Quantity "s") := default
  time_measurement_slice_method : IMAS.«core_profiles/profiles_1d/electrons/temperature_fit/time_measurement_slice_method» := default
  time_measurement_width : Array (Quantity "s") := default
  time_measurement_width_error_upper : Array (Quantity "s") := default
  time_measurement_width_error_lower : Array (Quantity "s") := default
  «local» : Array Int32 := default
  rho_tor_norm : Array (Quantity "1") := default
  rho_tor_norm_error_upper : Array (Quantity "1") := default
  rho_tor_norm_error_lower : Array (Quantity "1") := default
  weight : Array (Quantity "1") := default
  weight_error_upper : Array (Quantity "1") := default
  weight_error_lower : Array (Quantity "1") := default
  reconstructed : Array (Quantity "mixed") := default
  reconstructed_error_upper : Array (Quantity "mixed") := default
  reconstructed_error_lower : Array (Quantity "mixed") := default
  chi_squared : Array (Quantity "1") := default
  chi_squared_error_upper : Array (Quantity "1") := default
  chi_squared_error_lower : Array (Quantity "1") := default
  parameters : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/electrons/density_fit/time_measurement_slice_method» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/electrons/density_fit» where
  measured : Array (Quantity "mixed") := default
  measured_error_upper : Array (Quantity "mixed") := default
  measured_error_lower : Array (Quantity "mixed") := default
  source : Array String := default
  time_measurement : Array (Quantity "s") := default
  time_measurement_error_upper : Array (Quantity "s") := default
  time_measurement_error_lower : Array (Quantity "s") := default
  time_measurement_slice_method : IMAS.«core_profiles/profiles_1d/electrons/density_fit/time_measurement_slice_method» := default
  time_measurement_width : Array (Quantity "s") := default
  time_measurement_width_error_upper : Array (Quantity "s") := default
  time_measurement_width_error_lower : Array (Quantity "s") := default
  «local» : Array Int32 := default
  rho_tor_norm : Array (Quantity "1") := default
  rho_tor_norm_error_upper : Array (Quantity "1") := default
  rho_tor_norm_error_lower : Array (Quantity "1") := default
  weight : Array (Quantity "1") := default
  weight_error_upper : Array (Quantity "1") := default
  weight_error_lower : Array (Quantity "1") := default
  reconstructed : Array (Quantity "mixed") := default
  reconstructed_error_upper : Array (Quantity "mixed") := default
  reconstructed_error_lower : Array (Quantity "mixed") := default
  chi_squared : Array (Quantity "1") := default
  chi_squared_error_upper : Array (Quantity "1") := default
  chi_squared_error_lower : Array (Quantity "1") := default
  parameters : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/electrons» where
  temperature : Array (Quantity "eV") := default
  temperature_error_upper : Array (Quantity "eV") := default
  temperature_error_lower : Array (Quantity "eV") := default
  temperature_validity : Option Int32 := default
  temperature_fit : Quantity "eV" IMAS.«core_profiles/profiles_1d/electrons/temperature_fit» := default
  density : Array (Quantity "m^-3") := default
  density_error_upper : Array (Quantity "m^-3") := default
  density_error_lower : Array (Quantity "m^-3") := default
  density_validity : Option Int32 := default
  density_fit : Quantity "m^-3" IMAS.«core_profiles/profiles_1d/electrons/density_fit» := default
  density_thermal : Array (Quantity "m^-3") := default
  density_thermal_error_upper : Array (Quantity "m^-3") := default
  density_thermal_error_lower : Array (Quantity "m^-3") := default
  density_fast : Array (Quantity "m^-3") := default
  density_fast_error_upper : Array (Quantity "m^-3") := default
  density_fast_error_lower : Array (Quantity "m^-3") := default
  pressure : Array (Quantity "Pa") := default
  pressure_error_upper : Array (Quantity "Pa") := default
  pressure_error_lower : Array (Quantity "Pa") := default
  pressure_thermal : Array (Quantity "Pa") := default
  pressure_thermal_error_upper : Array (Quantity "Pa") := default
  pressure_thermal_error_lower : Array (Quantity "Pa") := default
  pressure_fast_perpendicular : Array (Quantity "Pa") := default
  pressure_fast_perpendicular_error_upper : Array (Quantity "Pa") := default
  pressure_fast_perpendicular_error_lower : Array (Quantity "Pa") := default
  pressure_fast_parallel : Array (Quantity "Pa") := default
  pressure_fast_parallel_error_upper : Array (Quantity "Pa") := default
  pressure_fast_parallel_error_lower : Array (Quantity "Pa") := default
  collisionality_norm : Array (Quantity "1") := default
  collisionality_norm_error_upper : Array (Quantity "1") := default
  collisionality_norm_error_lower : Array (Quantity "1") := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/element» where
  a : Option (Quantity "u") := default
  a_error_upper : Option (Quantity "u") := default
  a_error_lower : Option (Quantity "u") := default
  z_n : Option (Quantity "e" Int32) := default
  atoms_n : Option Int32 := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/temperature_fit/time_measurement_slice_method» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/temperature_fit» where
  measured : Array (Quantity "mixed") := default
  measured_error_upper : Array (Quantity "mixed") := default
  measured_error_lower : Array (Quantity "mixed") := default
  source : Array String := default
  time_measurement : Array (Quantity "s") := default
  time_measurement_error_upper : Array (Quantity "s") := default
  time_measurement_error_lower : Array (Quantity "s") := default
  time_measurement_slice_method : IMAS.«core_profiles/profiles_1d/ion/temperature_fit/time_measurement_slice_method» := default
  time_measurement_width : Array (Quantity "s") := default
  time_measurement_width_error_upper : Array (Quantity "s") := default
  time_measurement_width_error_lower : Array (Quantity "s") := default
  «local» : Array Int32 := default
  rho_tor_norm : Array (Quantity "1") := default
  rho_tor_norm_error_upper : Array (Quantity "1") := default
  rho_tor_norm_error_lower : Array (Quantity "1") := default
  weight : Array (Quantity "1") := default
  weight_error_upper : Array (Quantity "1") := default
  weight_error_lower : Array (Quantity "1") := default
  reconstructed : Array (Quantity "mixed") := default
  reconstructed_error_upper : Array (Quantity "mixed") := default
  reconstructed_error_lower : Array (Quantity "mixed") := default
  chi_squared : Array (Quantity "1") := default
  chi_squared_error_upper : Array (Quantity "1") := default
  chi_squared_error_lower : Array (Quantity "1") := default
  parameters : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/density_fit/time_measurement_slice_method» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/density_fit» where
  measured : Array (Quantity "mixed") := default
  measured_error_upper : Array (Quantity "mixed") := default
  measured_error_lower : Array (Quantity "mixed") := default
  source : Array String := default
  time_measurement : Array (Quantity "s") := default
  time_measurement_error_upper : Array (Quantity "s") := default
  time_measurement_error_lower : Array (Quantity "s") := default
  time_measurement_slice_method : IMAS.«core_profiles/profiles_1d/ion/density_fit/time_measurement_slice_method» := default
  time_measurement_width : Array (Quantity "s") := default
  time_measurement_width_error_upper : Array (Quantity "s") := default
  time_measurement_width_error_lower : Array (Quantity "s") := default
  «local» : Array Int32 := default
  rho_tor_norm : Array (Quantity "1") := default
  rho_tor_norm_error_upper : Array (Quantity "1") := default
  rho_tor_norm_error_lower : Array (Quantity "1") := default
  weight : Array (Quantity "1") := default
  weight_error_upper : Array (Quantity "1") := default
  weight_error_lower : Array (Quantity "1") := default
  reconstructed : Array (Quantity "mixed") := default
  reconstructed_error_upper : Array (Quantity "mixed") := default
  reconstructed_error_lower : Array (Quantity "mixed") := default
  chi_squared : Array (Quantity "1") := default
  chi_squared_error_upper : Array (Quantity "1") := default
  chi_squared_error_lower : Array (Quantity "1") := default
  parameters : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/velocity» where
  radial : Array (Quantity "m.s^-1") := default
  radial_error_upper : Array (Quantity "m.s^-1") := default
  radial_error_lower : Array (Quantity "m.s^-1") := default
  diamagnetic : Array (Quantity "m.s^-1") := default
  diamagnetic_error_upper : Array (Quantity "m.s^-1") := default
  diamagnetic_error_lower : Array (Quantity "m.s^-1") := default
  parallel : Array (Quantity "m.s^-1") := default
  parallel_error_upper : Array (Quantity "m.s^-1") := default
  parallel_error_lower : Array (Quantity "m.s^-1") := default
  poloidal : Array (Quantity "m.s^-1") := default
  poloidal_error_upper : Array (Quantity "m.s^-1") := default
  poloidal_error_lower : Array (Quantity "m.s^-1") := default
  toroidal : Array (Quantity "m.s^-1") := default
  toroidal_error_upper : Array (Quantity "m.s^-1") := default
  toroidal_error_lower : Array (Quantity "m.s^-1") := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/state/velocity» where
  radial : Array (Quantity "m.s^-1") := default
  radial_error_upper : Array (Quantity "m.s^-1") := default
  radial_error_lower : Array (Quantity "m.s^-1") := default
  diamagnetic : Array (Quantity "m.s^-1") := default
  diamagnetic_error_upper : Array (Quantity "m.s^-1") := default
  diamagnetic_error_lower : Array (Quantity "m.s^-1") := default
  parallel : Array (Quantity "m.s^-1") := default
  parallel_error_upper : Array (Quantity "m.s^-1") := default
  parallel_error_lower : Array (Quantity "m.s^-1") := default
  poloidal : Array (Quantity "m.s^-1") := default
  poloidal_error_upper : Array (Quantity "m.s^-1") := default
  poloidal_error_lower : Array (Quantity "m.s^-1") := default
  toroidal : Array (Quantity "m.s^-1") := default
  toroidal_error_upper : Array (Quantity "m.s^-1") := default
  toroidal_error_lower : Array (Quantity "m.s^-1") := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/state/density_fit/time_measurement_slice_method» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/state/density_fit» where
  measured : Array (Quantity "mixed") := default
  measured_error_upper : Array (Quantity "mixed") := default
  measured_error_lower : Array (Quantity "mixed") := default
  source : Array String := default
  time_measurement : Array (Quantity "s") := default
  time_measurement_error_upper : Array (Quantity "s") := default
  time_measurement_error_lower : Array (Quantity "s") := default
  time_measurement_slice_method : IMAS.«core_profiles/profiles_1d/ion/state/density_fit/time_measurement_slice_method» := default
  time_measurement_width : Array (Quantity "s") := default
  time_measurement_width_error_upper : Array (Quantity "s") := default
  time_measurement_width_error_lower : Array (Quantity "s") := default
  «local» : Array Int32 := default
  rho_tor_norm : Array (Quantity "1") := default
  rho_tor_norm_error_upper : Array (Quantity "1") := default
  rho_tor_norm_error_lower : Array (Quantity "1") := default
  weight : Array (Quantity "1") := default
  weight_error_upper : Array (Quantity "1") := default
  weight_error_lower : Array (Quantity "1") := default
  reconstructed : Array (Quantity "mixed") := default
  reconstructed_error_upper : Array (Quantity "mixed") := default
  reconstructed_error_lower : Array (Quantity "mixed") := default
  chi_squared : Array (Quantity "1") := default
  chi_squared_error_upper : Array (Quantity "1") := default
  chi_squared_error_lower : Array (Quantity "1") := default
  parameters : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/state» where
  z_min : Option (Quantity "e") := default
  z_min_error_upper : Option (Quantity "e") := default
  z_min_error_lower : Option (Quantity "e") := default
  z_max : Option (Quantity "e") := default
  z_max_error_upper : Option (Quantity "e") := default
  z_max_error_lower : Option (Quantity "e") := default
  z_average : Option (Quantity "e") := default
  z_average_error_upper : Option (Quantity "e") := default
  z_average_error_lower : Option (Quantity "e") := default
  z_square_average : Option (Quantity "e") := default
  z_square_average_error_upper : Option (Quantity "e") := default
  z_square_average_error_lower : Option (Quantity "e") := default
  z_average_1d : Array (Quantity "1") := default
  z_average_1d_error_upper : Array (Quantity "1") := default
  z_average_1d_error_lower : Array (Quantity "1") := default
  z_average_square_1d : Array (Quantity "1") := default
  z_average_square_1d_error_upper : Array (Quantity "1") := default
  z_average_square_1d_error_lower : Array (Quantity "1") := default
  ionization_potential : Option (Quantity "eV") := default
  ionization_potential_error_upper : Option (Quantity "eV") := default
  ionization_potential_error_lower : Option (Quantity "eV") := default
  name : Option String := default
  electron_configuration : Option String := default
  vibrational_level : Option (Quantity "e") := default
  vibrational_level_error_upper : Option (Quantity "e") := default
  vibrational_level_error_lower : Option (Quantity "e") := default
  vibrational_mode : Option String := default
  rotation_frequency_tor : Array (Quantity "rad.s^-1") := default
  rotation_frequency_tor_error_upper : Array (Quantity "rad.s^-1") := default
  rotation_frequency_tor_error_lower : Array (Quantity "rad.s^-1") := default
  velocity : Quantity "m.s^-1" IMAS.«core_profiles/profiles_1d/ion/state/velocity» := default
  temperature : Array (Quantity "eV") := default
  temperature_error_upper : Array (Quantity "eV") := default
  temperature_error_lower : Array (Quantity "eV") := default
  density : Array (Quantity "m^-3") := default
  density_error_upper : Array (Quantity "m^-3") := default
  density_error_lower : Array (Quantity "m^-3") := default
  density_fit : Quantity "m^-3" IMAS.«core_profiles/profiles_1d/ion/state/density_fit» := default
  density_thermal : Array (Quantity "m^-3") := default
  density_thermal_error_upper : Array (Quantity "m^-3") := default
  density_thermal_error_lower : Array (Quantity "m^-3") := default
  density_fast : Array (Quantity "m^-3") := default
  density_fast_error_upper : Array (Quantity "m^-3") := default
  density_fast_error_lower : Array (Quantity "m^-3") := default
  pressure : Array (Quantity "Pa") := default
  pressure_error_upper : Array (Quantity "Pa") := default
  pressure_error_lower : Array (Quantity "Pa") := default
  pressure_thermal : Array (Quantity "Pa") := default
  pressure_thermal_error_upper : Array (Quantity "Pa") := default
  pressure_thermal_error_lower : Array (Quantity "Pa") := default
  pressure_fast_perpendicular : Array (Quantity "Pa") := default
  pressure_fast_perpendicular_error_upper : Array (Quantity "Pa") := default
  pressure_fast_perpendicular_error_lower : Array (Quantity "Pa") := default
  pressure_fast_parallel : Array (Quantity "Pa") := default
  pressure_fast_parallel_error_upper : Array (Quantity "Pa") := default
  pressure_fast_parallel_error_lower : Array (Quantity "Pa") := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion» where
  element : Array IMAS.«core_profiles/profiles_1d/ion/element» := default
  z_ion : Option (Quantity "e") := default
  z_ion_error_upper : Option (Quantity "e") := default
  z_ion_error_lower : Option (Quantity "e") := default
  name : Option String := default
  neutral_index : Option Int32 := default
  z_ion_1d : Array (Quantity "1") := default
  z_ion_1d_error_upper : Array (Quantity "1") := default
  z_ion_1d_error_lower : Array (Quantity "1") := default
  z_ion_square_1d : Array (Quantity "1") := default
  z_ion_square_1d_error_upper : Array (Quantity "1") := default
  z_ion_square_1d_error_lower : Array (Quantity "1") := default
  temperature : Array (Quantity "eV") := default
  temperature_error_upper : Array (Quantity "eV") := default
  temperature_error_lower : Array (Quantity "eV") := default
  temperature_validity : Option Int32 := default
  temperature_fit : Quantity "eV" IMAS.«core_profiles/profiles_1d/ion/temperature_fit» := default
  density : Array (Quantity "m^-3") := default
  density_error_upper : Array (Quantity "m^-3") := default
  density_error_lower : Array (Quantity "m^-3") := default
  density_validity : Option Int32 := default
  density_fit : Quantity "m^-3" IMAS.«core_profiles/profiles_1d/ion/density_fit» := default
  density_thermal : Array (Quantity "m^-3") := default
  density_thermal_error_upper : Array (Quantity "m^-3") := default
  density_thermal_error_lower : Array (Quantity "m^-3") := default
  density_fast : Array (Quantity "m^-3") := default
  density_fast_error_upper : Array (Quantity "m^-3") := default
  density_fast_error_lower : Array (Quantity "m^-3") := default
  pressure : Array (Quantity "Pa") := default
  pressure_error_upper : Array (Quantity "Pa") := default
  pressure_error_lower : Array (Quantity "Pa") := default
  pressure_thermal : Array (Quantity "Pa") := default
  pressure_thermal_error_upper : Array (Quantity "Pa") := default
  pressure_thermal_error_lower : Array (Quantity "Pa") := default
  pressure_fast_perpendicular : Array (Quantity "Pa") := default
  pressure_fast_perpendicular_error_upper : Array (Quantity "Pa") := default
  pressure_fast_perpendicular_error_lower : Array (Quantity "Pa") := default
  pressure_fast_parallel : Array (Quantity "Pa") := default
  pressure_fast_parallel_error_upper : Array (Quantity "Pa") := default
  pressure_fast_parallel_error_lower : Array (Quantity "Pa") := default
  rotation_frequency_tor : Array (Quantity "rad.s^-1") := default
  rotation_frequency_tor_error_upper : Array (Quantity "rad.s^-1") := default
  rotation_frequency_tor_error_lower : Array (Quantity "rad.s^-1") := default
  velocity : Quantity "m.s^-1" IMAS.«core_profiles/profiles_1d/ion/velocity» := default
  multiple_states_flag : Option Int32 := default
  state : Array IMAS.«core_profiles/profiles_1d/ion/state» := default
  deriving Inhabited

structure «core_profiles/profiles_1d/neutral/element» where
  a : Option (Quantity "u") := default
  a_error_upper : Option (Quantity "u") := default
  a_error_lower : Option (Quantity "u") := default
  z_n : Option (Quantity "e" Int32) := default
  atoms_n : Option Int32 := default
  deriving Inhabited

structure «core_profiles/profiles_1d/neutral/state/neutral_type» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/neutral/state» where
  name : Option String := default
  electron_configuration : Option String := default
  vibrational_level : Option (Quantity "e") := default
  vibrational_level_error_upper : Option (Quantity "e") := default
  vibrational_level_error_lower : Option (Quantity "e") := default
  vibrational_mode : Option String := default
  neutral_type : IMAS.«core_profiles/profiles_1d/neutral/state/neutral_type» := default
  temperature : Array (Quantity "eV") := default
  temperature_error_upper : Array (Quantity "eV") := default
  temperature_error_lower : Array (Quantity "eV") := default
  density : Array (Quantity "m^-3") := default
  density_error_upper : Array (Quantity "m^-3") := default
  density_error_lower : Array (Quantity "m^-3") := default
  density_thermal : Array (Quantity "m^-3") := default
  density_thermal_error_upper : Array (Quantity "m^-3") := default
  density_thermal_error_lower : Array (Quantity "m^-3") := default
  density_fast : Array (Quantity "m^-3") := default
  density_fast_error_upper : Array (Quantity "m^-3") := default
  density_fast_error_lower : Array (Quantity "m^-3") := default
  pressure : Array (Quantity "Pa") := default
  pressure_error_upper : Array (Quantity "Pa") := default
  pressure_error_lower : Array (Quantity "Pa") := default
  pressure_thermal : Array (Quantity "Pa") := default
  pressure_thermal_error_upper : Array (Quantity "Pa") := default
  pressure_thermal_error_lower : Array (Quantity "Pa") := default
  pressure_fast_perpendicular : Array (Quantity "Pa") := default
  pressure_fast_perpendicular_error_upper : Array (Quantity "Pa") := default
  pressure_fast_perpendicular_error_lower : Array (Quantity "Pa") := default
  pressure_fast_parallel : Array (Quantity "Pa") := default
  pressure_fast_parallel_error_upper : Array (Quantity "Pa") := default
  pressure_fast_parallel_error_lower : Array (Quantity "Pa") := default
  deriving Inhabited

structure «core_profiles/profiles_1d/neutral» where
  element : Array IMAS.«core_profiles/profiles_1d/neutral/element» := default
  name : Option String := default
  ion_index : Option Int32 := default
  temperature : Array (Quantity "eV") := default
  temperature_error_upper : Array (Quantity "eV") := default
  temperature_error_lower : Array (Quantity "eV") := default
  density : Array (Quantity "m^-3") := default
  density_error_upper : Array (Quantity "m^-3") := default
  density_error_lower : Array (Quantity "m^-3") := default
  density_thermal : Array (Quantity "m^-3") := default
  density_thermal_error_upper : Array (Quantity "m^-3") := default
  density_thermal_error_lower : Array (Quantity "m^-3") := default
  density_fast : Array (Quantity "m^-3") := default
  density_fast_error_upper : Array (Quantity "m^-3") := default
  density_fast_error_lower : Array (Quantity "m^-3") := default
  pressure : Array (Quantity "Pa") := default
  pressure_error_upper : Array (Quantity "Pa") := default
  pressure_error_lower : Array (Quantity "Pa") := default
  pressure_thermal : Array (Quantity "Pa") := default
  pressure_thermal_error_upper : Array (Quantity "Pa") := default
  pressure_thermal_error_lower : Array (Quantity "Pa") := default
  pressure_fast_perpendicular : Array (Quantity "Pa") := default
  pressure_fast_perpendicular_error_upper : Array (Quantity "Pa") := default
  pressure_fast_perpendicular_error_lower : Array (Quantity "Pa") := default
  pressure_fast_parallel : Array (Quantity "Pa") := default
  pressure_fast_parallel_error_upper : Array (Quantity "Pa") := default
  pressure_fast_parallel_error_lower : Array (Quantity "Pa") := default
  multiple_states_flag : Option Int32 := default
  state : Array IMAS.«core_profiles/profiles_1d/neutral/state» := default
  deriving Inhabited

structure «core_profiles/profiles_1d/t_i_average_fit/time_measurement_slice_method» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/t_i_average_fit» where
  measured : Array (Quantity "mixed") := default
  measured_error_upper : Array (Quantity "mixed") := default
  measured_error_lower : Array (Quantity "mixed") := default
  source : Array String := default
  time_measurement : Array (Quantity "s") := default
  time_measurement_error_upper : Array (Quantity "s") := default
  time_measurement_error_lower : Array (Quantity "s") := default
  time_measurement_slice_method : IMAS.«core_profiles/profiles_1d/t_i_average_fit/time_measurement_slice_method» := default
  time_measurement_width : Array (Quantity "s") := default
  time_measurement_width_error_upper : Array (Quantity "s") := default
  time_measurement_width_error_lower : Array (Quantity "s") := default
  «local» : Array Int32 := default
  rho_tor_norm : Array (Quantity "1") := default
  rho_tor_norm_error_upper : Array (Quantity "1") := default
  rho_tor_norm_error_lower : Array (Quantity "1") := default
  weight : Array (Quantity "1") := default
  weight_error_upper : Array (Quantity "1") := default
  weight_error_lower : Array (Quantity "1") := default
  reconstructed : Array (Quantity "mixed") := default
  reconstructed_error_upper : Array (Quantity "mixed") := default
  reconstructed_error_lower : Array (Quantity "mixed") := default
  chi_squared : Array (Quantity "1") := default
  chi_squared_error_upper : Array (Quantity "1") := default
  chi_squared_error_lower : Array (Quantity "1") := default
  parameters : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/zeff_fit/time_measurement_slice_method» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/zeff_fit» where
  measured : Array (Quantity "mixed") := default
  measured_error_upper : Array (Quantity "mixed") := default
  measured_error_lower : Array (Quantity "mixed") := default
  source : Array String := default
  time_measurement : Array (Quantity "s") := default
  time_measurement_error_upper : Array (Quantity "s") := default
  time_measurement_error_lower : Array (Quantity "s") := default
  time_measurement_slice_method : IMAS.«core_profiles/profiles_1d/zeff_fit/time_measurement_slice_method» := default
  time_measurement_width : Array (Quantity "s") := default
  time_measurement_width_error_upper : Array (Quantity "s") := default
  time_measurement_width_error_lower : Array (Quantity "s") := default
  «local» : Array Int32 := default
  rho_tor_norm : Array (Quantity "1") := default
  rho_tor_norm_error_upper : Array (Quantity "1") := default
  rho_tor_norm_error_lower : Array (Quantity "1") := default
  weight : Array (Quantity "1") := default
  weight_error_upper : Array (Quantity "1") := default
  weight_error_lower : Array (Quantity "1") := default
  reconstructed : Array (Quantity "mixed") := default
  reconstructed_error_upper : Array (Quantity "mixed") := default
  reconstructed_error_lower : Array (Quantity "mixed") := default
  chi_squared : Array (Quantity "1") := default
  chi_squared_error_upper : Array (Quantity "1") := default
  chi_squared_error_lower : Array (Quantity "1") := default
  parameters : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/e_field» where
  radial : Array (Quantity "V.m^-1") := default
  radial_error_upper : Array (Quantity "V.m^-1") := default
  radial_error_lower : Array (Quantity "V.m^-1") := default
  diamagnetic : Array (Quantity "V.m^-1") := default
  diamagnetic_error_upper : Array (Quantity "V.m^-1") := default
  diamagnetic_error_lower : Array (Quantity "V.m^-1") := default
  parallel : Array (Quantity "V.m^-1") := default
  parallel_error_upper : Array (Quantity "V.m^-1") := default
  parallel_error_lower : Array (Quantity "V.m^-1") := default
  poloidal : Array (Quantity "V.m^-1") := default
  poloidal_error_upper : Array (Quantity "V.m^-1") := default
  poloidal_error_lower : Array (Quantity "V.m^-1") := default
  toroidal : Array (Quantity "V.m^-1") := default
  toroidal_error_upper : Array (Quantity "V.m^-1") := default
  toroidal_error_lower : Array (Quantity "V.m^-1") := default
  deriving Inhabited

structure «core_profiles/profiles_1d» where
  grid : IMAS.«core_profiles/profiles_1d/grid» := default
  electrons : IMAS.«core_profiles/profiles_1d/electrons» := default
  ion : Array IMAS.«core_profiles/profiles_1d/ion» := default
  neutral : Array IMAS.«core_profiles/profiles_1d/neutral» := default
  t_i_average : Array (Quantity "eV") := default
  t_i_average_error_upper : Array (Quantity "eV") := default
  t_i_average_error_lower : Array (Quantity "eV") := default
  t_i_average_fit : Quantity "eV" IMAS.«core_profiles/profiles_1d/t_i_average_fit» := default
  n_i_total_over_n_e : Array (Quantity "1") := default
  n_i_total_over_n_e_error_upper : Array (Quantity "1") := default
  n_i_total_over_n_e_error_lower : Array (Quantity "1") := default
  n_i_thermal_total : Array (Quantity "m^-3") := default
  n_i_thermal_total_error_upper : Array (Quantity "m^-3") := default
  n_i_thermal_total_error_lower : Array (Quantity "m^-3") := default
  momentum_phi : Array (Quantity "kg.m^-1.s^-1") := default
  momentum_phi_error_upper : Array (Quantity "kg.m^-1.s^-1") := default
  momentum_phi_error_lower : Array (Quantity "kg.m^-1.s^-1") := default
  zeff : Array (Quantity "1") := default
  zeff_error_upper : Array (Quantity "1") := default
  zeff_error_lower : Array (Quantity "1") := default
  zeff_fit : Quantity "1" IMAS.«core_profiles/profiles_1d/zeff_fit» := default
  pressure_ion_total : Array (Quantity "Pa") := default
  pressure_ion_total_error_upper : Array (Quantity "Pa") := default
  pressure_ion_total_error_lower : Array (Quantity "Pa") := default
  pressure_thermal : Array (Quantity "Pa") := default
  pressure_thermal_error_upper : Array (Quantity "Pa") := default
  pressure_thermal_error_lower : Array (Quantity "Pa") := default
  pressure_perpendicular : Array (Quantity "Pa") := default
  pressure_perpendicular_error_upper : Array (Quantity "Pa") := default
  pressure_perpendicular_error_lower : Array (Quantity "Pa") := default
  pressure_parallel : Array (Quantity "Pa") := default
  pressure_parallel_error_upper : Array (Quantity "Pa") := default
  pressure_parallel_error_lower : Array (Quantity "Pa") := default
  j_total : Array (Quantity "A.m^-2") := default
  j_total_error_upper : Array (Quantity "A.m^-2") := default
  j_total_error_lower : Array (Quantity "A.m^-2") := default
  current_parallel_inside : Array (Quantity "A") := default
  current_parallel_inside_error_upper : Array (Quantity "A") := default
  current_parallel_inside_error_lower : Array (Quantity "A") := default
  j_phi : Array (Quantity "A.m^-2") := default
  j_phi_error_upper : Array (Quantity "A.m^-2") := default
  j_phi_error_lower : Array (Quantity "A.m^-2") := default
  j_ohmic : Array (Quantity "A.m^-2") := default
  j_ohmic_error_upper : Array (Quantity "A.m^-2") := default
  j_ohmic_error_lower : Array (Quantity "A.m^-2") := default
  j_non_inductive : Array (Quantity "A.m^-2") := default
  j_non_inductive_error_upper : Array (Quantity "A.m^-2") := default
  j_non_inductive_error_lower : Array (Quantity "A.m^-2") := default
  j_bootstrap : Array (Quantity "A.m^-2") := default
  j_bootstrap_error_upper : Array (Quantity "A.m^-2") := default
  j_bootstrap_error_lower : Array (Quantity "A.m^-2") := default
  conductivity_parallel : Array (Quantity "ohm^-1.m^-1") := default
  conductivity_parallel_error_upper : Array (Quantity "ohm^-1.m^-1") := default
  conductivity_parallel_error_lower : Array (Quantity "ohm^-1.m^-1") := default
  e_field : Quantity "V.m^-1" IMAS.«core_profiles/profiles_1d/e_field» := default
  phi_potential : Array (Quantity "V") := default
  phi_potential_error_upper : Array (Quantity "V") := default
  phi_potential_error_lower : Array (Quantity "V") := default
  rotation_frequency_tor_sonic : Array (Quantity "s^-1") := default
  rotation_frequency_tor_sonic_error_upper : Array (Quantity "s^-1") := default
  rotation_frequency_tor_sonic_error_lower : Array (Quantity "s^-1") := default
  q : Array (Quantity "1") := default
  q_error_upper : Array (Quantity "1") := default
  q_error_lower : Array (Quantity "1") := default
  magnetic_shear : Array (Quantity "1") := default
  magnetic_shear_error_upper : Array (Quantity "1") := default
  magnetic_shear_error_lower : Array (Quantity "1") := default
  time : Option (Quantity "s") := default
  deriving Inhabited

structure «core_profiles/profiles_2d/grid_type» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_2d/grid» where
  dim1 : Array (Quantity "mixed") := default
  dim1_error_upper : Array (Quantity "mixed") := default
  dim1_error_lower : Array (Quantity "mixed") := default
  dim2 : Array (Quantity "mixed") := default
  dim2_error_upper : Array (Quantity "mixed") := default
  dim2_error_lower : Array (Quantity "mixed") := default
  volume_element : Matrix (Quantity "m^3") := default
  volume_element_error_upper : Matrix (Quantity "m^3") := default
  volume_element_error_lower : Matrix (Quantity "m^3") := default
  deriving Inhabited

structure «core_profiles/profiles_2d/ion/element» where
  a : Option (Quantity "u") := default
  a_error_upper : Option (Quantity "u") := default
  a_error_lower : Option (Quantity "u") := default
  z_n : Option (Quantity "e" Int32) := default
  atoms_n : Option Int32 := default
  deriving Inhabited

structure «core_profiles/profiles_2d/ion/velocity» where
  radial : Matrix (Quantity "m.s^-1") := default
  radial_error_upper : Matrix (Quantity "m.s^-1") := default
  radial_error_lower : Matrix (Quantity "m.s^-1") := default
  diamagnetic : Matrix (Quantity "m.s^-1") := default
  diamagnetic_error_upper : Matrix (Quantity "m.s^-1") := default
  diamagnetic_error_lower : Matrix (Quantity "m.s^-1") := default
  parallel : Matrix (Quantity "m.s^-1") := default
  parallel_error_upper : Matrix (Quantity "m.s^-1") := default
  parallel_error_lower : Matrix (Quantity "m.s^-1") := default
  poloidal : Matrix (Quantity "m.s^-1") := default
  poloidal_error_upper : Matrix (Quantity "m.s^-1") := default
  poloidal_error_lower : Matrix (Quantity "m.s^-1") := default
  toroidal : Matrix (Quantity "m.s^-1") := default
  toroidal_error_upper : Matrix (Quantity "m.s^-1") := default
  toroidal_error_lower : Matrix (Quantity "m.s^-1") := default
  deriving Inhabited

structure «core_profiles/profiles_2d/ion/state» where
  z_min : Option (Quantity "e") := default
  z_min_error_upper : Option (Quantity "e") := default
  z_min_error_lower : Option (Quantity "e") := default
  z_max : Option (Quantity "e") := default
  z_max_error_upper : Option (Quantity "e") := default
  z_max_error_lower : Option (Quantity "e") := default
  z_average : Option (Quantity "e") := default
  z_average_error_upper : Option (Quantity "e") := default
  z_average_error_lower : Option (Quantity "e") := default
  z_square_average : Option (Quantity "e") := default
  z_square_average_error_upper : Option (Quantity "e") := default
  z_square_average_error_lower : Option (Quantity "e") := default
  ionization_potential : Option (Quantity "eV") := default
  ionization_potential_error_upper : Option (Quantity "eV") := default
  ionization_potential_error_lower : Option (Quantity "eV") := default
  name : Option String := default
  electron_configuration : Option String := default
  vibrational_level : Option (Quantity "e") := default
  vibrational_level_error_upper : Option (Quantity "e") := default
  vibrational_level_error_lower : Option (Quantity "e") := default
  vibrational_mode : Option String := default
  rotation_frequency_tor : Matrix (Quantity "rad.s^-1") := default
  rotation_frequency_tor_error_upper : Matrix (Quantity "rad.s^-1") := default
  rotation_frequency_tor_error_lower : Matrix (Quantity "rad.s^-1") := default
  temperature : Matrix (Quantity "eV") := default
  temperature_error_upper : Matrix (Quantity "eV") := default
  temperature_error_lower : Matrix (Quantity "eV") := default
  density : Matrix (Quantity "m^-3") := default
  density_error_upper : Matrix (Quantity "m^-3") := default
  density_error_lower : Matrix (Quantity "m^-3") := default
  density_thermal : Matrix (Quantity "m^-3") := default
  density_thermal_error_upper : Matrix (Quantity "m^-3") := default
  density_thermal_error_lower : Matrix (Quantity "m^-3") := default
  density_fast : Matrix (Quantity "m^-3") := default
  density_fast_error_upper : Matrix (Quantity "m^-3") := default
  density_fast_error_lower : Matrix (Quantity "m^-3") := default
  pressure : Matrix (Quantity "Pa") := default
  pressure_error_upper : Matrix (Quantity "Pa") := default
  pressure_error_lower : Matrix (Quantity "Pa") := default
  pressure_thermal : Matrix (Quantity "Pa") := default
  pressure_thermal_error_upper : Matrix (Quantity "Pa") := default
  pressure_thermal_error_lower : Matrix (Quantity "Pa") := default
  pressure_fast_perpendicular : Matrix (Quantity "Pa") := default
  pressure_fast_perpendicular_error_upper : Matrix (Quantity "Pa") := default
  pressure_fast_perpendicular_error_lower : Matrix (Quantity "Pa") := default
  pressure_fast_parallel : Matrix (Quantity "Pa") := default
  pressure_fast_parallel_error_upper : Matrix (Quantity "Pa") := default
  pressure_fast_parallel_error_lower : Matrix (Quantity "Pa") := default
  deriving Inhabited

structure «core_profiles/profiles_2d/ion» where
  element : Array IMAS.«core_profiles/profiles_2d/ion/element» := default
  z_ion : Option (Quantity "e") := default
  z_ion_error_upper : Option (Quantity "e") := default
  z_ion_error_lower : Option (Quantity "e") := default
  name : Option String := default
  ion_index : Option Int32 := default
  temperature : Matrix (Quantity "eV") := default
  temperature_error_upper : Matrix (Quantity "eV") := default
  temperature_error_lower : Matrix (Quantity "eV") := default
  density : Matrix (Quantity "m^-3") := default
  density_error_upper : Matrix (Quantity "m^-3") := default
  density_error_lower : Matrix (Quantity "m^-3") := default
  density_thermal : Matrix (Quantity "m^-3") := default
  density_thermal_error_upper : Matrix (Quantity "m^-3") := default
  density_thermal_error_lower : Matrix (Quantity "m^-3") := default
  density_fast : Matrix (Quantity "m^-3") := default
  density_fast_error_upper : Matrix (Quantity "m^-3") := default
  density_fast_error_lower : Matrix (Quantity "m^-3") := default
  pressure : Matrix (Quantity "Pa") := default
  pressure_error_upper : Matrix (Quantity "Pa") := default
  pressure_error_lower : Matrix (Quantity "Pa") := default
  pressure_thermal : Matrix (Quantity "Pa") := default
  pressure_thermal_error_upper : Matrix (Quantity "Pa") := default
  pressure_thermal_error_lower : Matrix (Quantity "Pa") := default
  pressure_fast_perpendicular : Matrix (Quantity "Pa") := default
  pressure_fast_perpendicular_error_upper : Matrix (Quantity "Pa") := default
  pressure_fast_perpendicular_error_lower : Matrix (Quantity "Pa") := default
  pressure_fast_parallel : Matrix (Quantity "Pa") := default
  pressure_fast_parallel_error_upper : Matrix (Quantity "Pa") := default
  pressure_fast_parallel_error_lower : Matrix (Quantity "Pa") := default
  rotation_frequency_tor : Matrix (Quantity "rad.s^-1") := default
  rotation_frequency_tor_error_upper : Matrix (Quantity "rad.s^-1") := default
  rotation_frequency_tor_error_lower : Matrix (Quantity "rad.s^-1") := default
  velocity : Quantity "m.s^-1" IMAS.«core_profiles/profiles_2d/ion/velocity» := default
  multiple_states_flag : Option Int32 := default
  state : Array IMAS.«core_profiles/profiles_2d/ion/state» := default
  deriving Inhabited

structure «core_profiles/profiles_2d» where
  grid_type : IMAS.«core_profiles/profiles_2d/grid_type» := default
  grid : IMAS.«core_profiles/profiles_2d/grid» := default
  ion : Array IMAS.«core_profiles/profiles_2d/ion» := default
  t_i_average : Matrix (Quantity "eV") := default
  t_i_average_error_upper : Matrix (Quantity "eV") := default
  t_i_average_error_lower : Matrix (Quantity "eV") := default
  n_i_total_over_n_e : Matrix (Quantity "1") := default
  n_i_total_over_n_e_error_upper : Matrix (Quantity "1") := default
  n_i_total_over_n_e_error_lower : Matrix (Quantity "1") := default
  n_i_thermal_total : Matrix (Quantity "m^-3") := default
  n_i_thermal_total_error_upper : Matrix (Quantity "m^-3") := default
  n_i_thermal_total_error_lower : Matrix (Quantity "m^-3") := default
  momentum_phi : Matrix (Quantity "kg.m^-1.s^-1") := default
  momentum_phi_error_upper : Matrix (Quantity "kg.m^-1.s^-1") := default
  momentum_phi_error_lower : Matrix (Quantity "kg.m^-1.s^-1") := default
  zeff : Matrix (Quantity "1") := default
  zeff_error_upper : Matrix (Quantity "1") := default
  zeff_error_lower : Matrix (Quantity "1") := default
  pressure_ion_total : Matrix (Quantity "Pa") := default
  pressure_ion_total_error_upper : Matrix (Quantity "Pa") := default
  pressure_ion_total_error_lower : Matrix (Quantity "Pa") := default
  pressure_thermal : Matrix (Quantity "Pa") := default
  pressure_thermal_error_upper : Matrix (Quantity "Pa") := default
  pressure_thermal_error_lower : Matrix (Quantity "Pa") := default
  pressure_perpendicular : Matrix (Quantity "Pa") := default
  pressure_perpendicular_error_upper : Matrix (Quantity "Pa") := default
  pressure_perpendicular_error_lower : Matrix (Quantity "Pa") := default
  pressure_parallel : Matrix (Quantity "Pa") := default
  pressure_parallel_error_upper : Matrix (Quantity "Pa") := default
  pressure_parallel_error_lower : Matrix (Quantity "Pa") := default
  time : Option (Quantity "s") := default
  deriving Inhabited

structure «core_profiles/global_quantities/ion» where
  t_i_volume_average : Array (Quantity "eV") := default
  t_i_volume_average_error_upper : Array (Quantity "eV") := default
  t_i_volume_average_error_lower : Array (Quantity "eV") := default
  n_i_volume_average : Array (Quantity "m^-3") := default
  n_i_volume_average_error_upper : Array (Quantity "m^-3") := default
  n_i_volume_average_error_lower : Array (Quantity "m^-3") := default
  deriving Inhabited

structure «core_profiles/global_quantities» where
  ip : Array (Quantity "A") := default
  ip_error_upper : Array (Quantity "A") := default
  ip_error_lower : Array (Quantity "A") := default
  current_non_inductive : Array (Quantity "A") := default
  current_non_inductive_error_upper : Array (Quantity "A") := default
  current_non_inductive_error_lower : Array (Quantity "A") := default
  current_bootstrap : Array (Quantity "A") := default
  current_bootstrap_error_upper : Array (Quantity "A") := default
  current_bootstrap_error_lower : Array (Quantity "A") := default
  v_loop : Array (Quantity "V") := default
  v_loop_error_upper : Array (Quantity "V") := default
  v_loop_error_lower : Array (Quantity "V") := default
  li_3 : Array (Quantity "1") := default
  li_3_error_upper : Array (Quantity "1") := default
  li_3_error_lower : Array (Quantity "1") := default
  beta_tor : Array (Quantity "1") := default
  beta_tor_error_upper : Array (Quantity "1") := default
  beta_tor_error_lower : Array (Quantity "1") := default
  beta_tor_norm : Array (Quantity "1") := default
  beta_tor_norm_error_upper : Array (Quantity "1") := default
  beta_tor_norm_error_lower : Array (Quantity "1") := default
  beta_pol : Array (Quantity "1") := default
  beta_pol_error_upper : Array (Quantity "1") := default
  beta_pol_error_lower : Array (Quantity "1") := default
  energy_diamagnetic : Array (Quantity "J") := default
  energy_diamagnetic_error_upper : Array (Quantity "J") := default
  energy_diamagnetic_error_lower : Array (Quantity "J") := default
  z_eff_resistive : Array (Quantity "1") := default
  z_eff_resistive_error_upper : Array (Quantity "1") := default
  z_eff_resistive_error_lower : Array (Quantity "1") := default
  t_e_peaking : Array (Quantity "1") := default
  t_e_peaking_error_upper : Array (Quantity "1") := default
  t_e_peaking_error_lower : Array (Quantity "1") := default
  t_i_average_peaking : Array (Quantity "1") := default
  t_i_average_peaking_error_upper : Array (Quantity "1") := default
  t_i_average_peaking_error_lower : Array (Quantity "1") := default
  resistive_psi_losses : Array (Quantity "Wb") := default
  resistive_psi_losses_error_upper : Array (Quantity "Wb") := default
  resistive_psi_losses_error_lower : Array (Quantity "Wb") := default
  ejima : Array (Quantity "1") := default
  ejima_error_upper : Array (Quantity "1") := default
  ejima_error_lower : Array (Quantity "1") := default
  t_e_volume_average : Array (Quantity "eV") := default
  t_e_volume_average_error_upper : Array (Quantity "eV") := default
  t_e_volume_average_error_lower : Array (Quantity "eV") := default
  n_e_volume_average : Array (Quantity "m^-3") := default
  n_e_volume_average_error_upper : Array (Quantity "m^-3") := default
  n_e_volume_average_error_lower : Array (Quantity "m^-3") := default
  ion : Array IMAS.«core_profiles/global_quantities/ion» := default
  ion_time_slice : Option (Quantity "s") := default
  ion_time_slice_error_upper : Option (Quantity "s") := default
  ion_time_slice_error_lower : Option (Quantity "s") := default
  deriving Inhabited

structure «core_profiles/vacuum_toroidal_field» where
  r0 : Option (Quantity "m") := default
  r0_error_upper : Option (Quantity "m") := default
  r0_error_lower : Option (Quantity "m") := default
  b0 : Array (Quantity "T") := default
  b0_error_upper : Array (Quantity "T") := default
  b0_error_lower : Array (Quantity "T") := default
  deriving Inhabited

structure «core_profiles/covariance» where
  description : Option String := default
  rows_uri : Array String := default
  data : Matrix (Quantity "mixed") := default
  data_error_upper : Matrix (Quantity "mixed") := default
  data_error_lower : Matrix (Quantity "mixed") := default
  deriving Inhabited

structure «core_profiles/statistics/quantity_2d/statistics_type/identifier» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/statistics/quantity_2d/statistics_type» where
  identifier : IMAS.«core_profiles/statistics/quantity_2d/statistics_type/identifier» := default
  value : Array (Quantity "mixed") := default
  value_error_upper : Array (Quantity "mixed") := default
  value_error_lower : Array (Quantity "mixed") := default
  grid_subset_index : Option Int32 := default
  grid_index : Option Int32 := default
  uq_input_path : Option Int32 := default
  deriving Inhabited

structure «core_profiles/statistics/quantity_2d/distribution» where
  bins : Matrix (Quantity "mixed") := default
  bins_error_upper : Matrix (Quantity "mixed") := default
  bins_error_lower : Matrix (Quantity "mixed") := default
  probability : Matrix (Quantity "1") := default
  probability_error_upper : Matrix (Quantity "1") := default
  probability_error_lower : Matrix (Quantity "1") := default
  deriving Inhabited

structure «core_profiles/statistics/quantity_2d» where
  path : Option String := default
  statistics_type : Array IMAS.«core_profiles/statistics/quantity_2d/statistics_type» := default
  distribution : IMAS.«core_profiles/statistics/quantity_2d/distribution» := default
  deriving Inhabited

structure «core_profiles/statistics/uq_input_2d/distribution» where
  bins : Matrix (Quantity "mixed") := default
  bins_error_upper : Matrix (Quantity "mixed") := default
  bins_error_lower : Matrix (Quantity "mixed") := default
  probability : Matrix (Quantity "1") := default
  probability_error_upper : Matrix (Quantity "1") := default
  probability_error_lower : Matrix (Quantity "1") := default
  deriving Inhabited

structure «core_profiles/statistics/uq_input_2d» where
  path : Option String := default
  distribution : IMAS.«core_profiles/statistics/uq_input_2d/distribution» := default
  deriving Inhabited

structure «core_profiles/statistics» where
  quantity_2d : Array IMAS.«core_profiles/statistics/quantity_2d» := default
  uq_input_2d : Array IMAS.«core_profiles/statistics/uq_input_2d» := default
  time_width : Option (Quantity "s") := default
  time_width_error_upper : Option (Quantity "s") := default
  time_width_error_lower : Option (Quantity "s") := default
  time : Option (Quantity "s") := default
  deriving Inhabited

structure «core_profiles/code/library» where
  name : Option String := default
  description : Option String := default
  commit : Option String := default
  version : Option String := default
  repository : Option String := default
  parameters : Option String := default
  deriving Inhabited

structure «core_profiles/code» where
  name : Option String := default
  description : Option String := default
  commit : Option String := default
  version : Option String := default
  repository : Option String := default
  parameters : Option String := default
  output_flag : Array Int32 := default
  library : Array IMAS.«core_profiles/code/library» := default
  deriving Inhabited

structure «core_profiles» where
  ids_properties : IMAS.«core_profiles/ids_properties» := default
  profiles_1d : Array IMAS.«core_profiles/profiles_1d» := default
  profiles_2d : Array IMAS.«core_profiles/profiles_2d» := default
  global_quantities : IMAS.«core_profiles/global_quantities» := default
  vacuum_toroidal_field : IMAS.«core_profiles/vacuum_toroidal_field» := default
  covariance : IMAS.«core_profiles/covariance» := default
  statistics : Array IMAS.«core_profiles/statistics» := default
  code : IMAS.«core_profiles/code» := default
  time : Array (Quantity "s") := default
  deriving Inhabited

def «core_profiles/profiles_1d/grid».coordinatesValidBool (data : «core_profiles/profiles_1d/grid») : Bool :=
  let coordinates1 := [data.rho_tor_norm.size]
  let coordinates2 := [data.rho_tor_norm_error_upper.size]
  let coordinates3 := [data.rho_tor_norm.size,
    data.rho_tor.size,
    data.psi.size,
    data.volume.size,
    data.area.size,
    data.surface.size,
    data.rho_pol_norm.size]
  (data.rho_tor_norm_error_upper.size == 0 || coordinateSizesMatch data.rho_tor_norm_error_upper.size coordinates1) &&
  (data.rho_tor_norm_error_lower.size == 0 || coordinateSizesMatch data.rho_tor_norm_error_lower.size coordinates2) &&
  ([data.rho_tor.size,
    data.rho_tor_error_upper.size,
    data.rho_tor_error_lower.size,
    data.rho_pol_norm.size,
    data.rho_pol_norm_error_upper.size,
    data.rho_pol_norm_error_lower.size,
    data.psi.size,
    data.psi_error_upper.size,
    data.psi_error_lower.size,
    data.volume.size,
    data.volume_error_upper.size,
    data.volume_error_lower.size,
    data.area.size,
    data.area_error_upper.size,
    data.area_error_lower.size,
    data.surface.size,
    data.surface_error_upper.size,
    data.surface_error_lower.size].all fun size =>
    size == 0 || coordinateSizesMatch size coordinates3)

def «core_profiles/profiles_1d/grid».coordinatesValid (data : «core_profiles/profiles_1d/grid») : Prop :=
  «core_profiles/profiles_1d/grid».coordinatesValidBool data = true

instance (data : «core_profiles/profiles_1d/grid») : Decidable («core_profiles/profiles_1d/grid».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_1d/grid».coordinatesValidBool data = true))

def «core_profiles/profiles_1d/grid».isValid (data : «core_profiles/profiles_1d/grid») : Prop :=
  «core_profiles/profiles_1d/grid».coordinatesValid data

instance (data : «core_profiles/profiles_1d/grid») : Decidable («core_profiles/profiles_1d/grid».isValid data) := by
  unfold «core_profiles/profiles_1d/grid».isValid
  infer_instance

def «core_profiles/profiles_1d/electrons/temperature_fit».coordinatesValidBool (data : «core_profiles/profiles_1d/electrons/temperature_fit») : Bool :=
  let coordinates1 := [data.measured.size]
  let coordinates2 := [data.measured_error_upper.size]
  ([data.measured_error_upper.size,
    data.source.size,
    data.time_measurement.size,
    data.time_measurement_error_upper.size,
    data.time_measurement_error_lower.size,
    data.time_measurement_width.size,
    data.time_measurement_width_error_upper.size,
    data.time_measurement_width_error_lower.size,
    data.local.size,
    data.rho_tor_norm.size,
    data.rho_tor_norm_error_upper.size,
    data.rho_tor_norm_error_lower.size,
    data.weight.size,
    data.weight_error_upper.size,
    data.weight_error_lower.size,
    data.reconstructed.size,
    data.reconstructed_error_upper.size,
    data.reconstructed_error_lower.size,
    data.chi_squared.size,
    data.chi_squared_error_upper.size,
    data.chi_squared_error_lower.size].all fun size =>
    size == 0 || coordinateSizesMatch size coordinates1) &&
  (data.measured_error_lower.size == 0 || coordinateSizesMatch data.measured_error_lower.size coordinates2)

def «core_profiles/profiles_1d/electrons/temperature_fit».coordinatesValid (data : «core_profiles/profiles_1d/electrons/temperature_fit») : Prop :=
  «core_profiles/profiles_1d/electrons/temperature_fit».coordinatesValidBool data = true

instance (data : «core_profiles/profiles_1d/electrons/temperature_fit») : Decidable («core_profiles/profiles_1d/electrons/temperature_fit».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_1d/electrons/temperature_fit».coordinatesValidBool data = true))

def «core_profiles/profiles_1d/electrons/temperature_fit».isValid (data : «core_profiles/profiles_1d/electrons/temperature_fit») : Prop :=
  «core_profiles/profiles_1d/electrons/temperature_fit».coordinatesValid data

instance (data : «core_profiles/profiles_1d/electrons/temperature_fit») : Decidable («core_profiles/profiles_1d/electrons/temperature_fit».isValid data) := by
  unfold «core_profiles/profiles_1d/electrons/temperature_fit».isValid
  infer_instance

def «core_profiles/profiles_1d/electrons/density_fit».coordinatesValidBool (data : «core_profiles/profiles_1d/electrons/density_fit») : Bool :=
  let coordinates1 := [data.measured.size]
  let coordinates2 := [data.measured_error_upper.size]
  ([data.measured_error_upper.size,
    data.source.size,
    data.time_measurement.size,
    data.time_measurement_error_upper.size,
    data.time_measurement_error_lower.size,
    data.time_measurement_width.size,
    data.time_measurement_width_error_upper.size,
    data.time_measurement_width_error_lower.size,
    data.local.size,
    data.rho_tor_norm.size,
    data.rho_tor_norm_error_upper.size,
    data.rho_tor_norm_error_lower.size,
    data.weight.size,
    data.weight_error_upper.size,
    data.weight_error_lower.size,
    data.reconstructed.size,
    data.reconstructed_error_upper.size,
    data.reconstructed_error_lower.size,
    data.chi_squared.size,
    data.chi_squared_error_upper.size,
    data.chi_squared_error_lower.size].all fun size =>
    size == 0 || coordinateSizesMatch size coordinates1) &&
  (data.measured_error_lower.size == 0 || coordinateSizesMatch data.measured_error_lower.size coordinates2)

def «core_profiles/profiles_1d/electrons/density_fit».coordinatesValid (data : «core_profiles/profiles_1d/electrons/density_fit») : Prop :=
  «core_profiles/profiles_1d/electrons/density_fit».coordinatesValidBool data = true

instance (data : «core_profiles/profiles_1d/electrons/density_fit») : Decidable («core_profiles/profiles_1d/electrons/density_fit».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_1d/electrons/density_fit».coordinatesValidBool data = true))

def «core_profiles/profiles_1d/electrons/density_fit».isValid (data : «core_profiles/profiles_1d/electrons/density_fit») : Prop :=
  «core_profiles/profiles_1d/electrons/density_fit».coordinatesValid data

instance (data : «core_profiles/profiles_1d/electrons/density_fit») : Decidable («core_profiles/profiles_1d/electrons/density_fit».isValid data) := by
  unfold «core_profiles/profiles_1d/electrons/density_fit».isValid
  infer_instance

def «core_profiles/profiles_1d/electrons».coordinatesValidBool (data : «core_profiles/profiles_1d/electrons») : Bool :=
  «core_profiles/profiles_1d/electrons/temperature_fit».coordinatesValidBool data.temperature_fit.value &&
  «core_profiles/profiles_1d/electrons/density_fit».coordinatesValidBool data.density_fit.value

def «core_profiles/profiles_1d/electrons».coordinatesValid (data : «core_profiles/profiles_1d/electrons») : Prop :=
  «core_profiles/profiles_1d/electrons».coordinatesValidBool data = true

instance (data : «core_profiles/profiles_1d/electrons») : Decidable («core_profiles/profiles_1d/electrons».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_1d/electrons».coordinatesValidBool data = true))

def «core_profiles/profiles_1d/electrons».isValid (data : «core_profiles/profiles_1d/electrons») : Prop :=
  «core_profiles/profiles_1d/electrons».coordinatesValid data

instance (data : «core_profiles/profiles_1d/electrons») : Decidable («core_profiles/profiles_1d/electrons».isValid data) := by
  unfold «core_profiles/profiles_1d/electrons».isValid
  infer_instance

def «core_profiles/profiles_1d/ion/temperature_fit».coordinatesValidBool (data : «core_profiles/profiles_1d/ion/temperature_fit») : Bool :=
  let coordinates1 := [data.measured.size]
  let coordinates2 := [data.measured_error_upper.size]
  ([data.measured_error_upper.size,
    data.source.size,
    data.time_measurement.size,
    data.time_measurement_error_upper.size,
    data.time_measurement_error_lower.size,
    data.time_measurement_width.size,
    data.time_measurement_width_error_upper.size,
    data.time_measurement_width_error_lower.size,
    data.local.size,
    data.rho_tor_norm.size,
    data.rho_tor_norm_error_upper.size,
    data.rho_tor_norm_error_lower.size,
    data.weight.size,
    data.weight_error_upper.size,
    data.weight_error_lower.size,
    data.reconstructed.size,
    data.reconstructed_error_upper.size,
    data.reconstructed_error_lower.size,
    data.chi_squared.size,
    data.chi_squared_error_upper.size,
    data.chi_squared_error_lower.size].all fun size =>
    size == 0 || coordinateSizesMatch size coordinates1) &&
  (data.measured_error_lower.size == 0 || coordinateSizesMatch data.measured_error_lower.size coordinates2)

def «core_profiles/profiles_1d/ion/temperature_fit».coordinatesValid (data : «core_profiles/profiles_1d/ion/temperature_fit») : Prop :=
  «core_profiles/profiles_1d/ion/temperature_fit».coordinatesValidBool data = true

instance (data : «core_profiles/profiles_1d/ion/temperature_fit») : Decidable («core_profiles/profiles_1d/ion/temperature_fit».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_1d/ion/temperature_fit».coordinatesValidBool data = true))

def «core_profiles/profiles_1d/ion/temperature_fit».isValid (data : «core_profiles/profiles_1d/ion/temperature_fit») : Prop :=
  «core_profiles/profiles_1d/ion/temperature_fit».coordinatesValid data

instance (data : «core_profiles/profiles_1d/ion/temperature_fit») : Decidable («core_profiles/profiles_1d/ion/temperature_fit».isValid data) := by
  unfold «core_profiles/profiles_1d/ion/temperature_fit».isValid
  infer_instance

def «core_profiles/profiles_1d/ion/density_fit».coordinatesValidBool (data : «core_profiles/profiles_1d/ion/density_fit») : Bool :=
  let coordinates1 := [data.measured.size]
  let coordinates2 := [data.measured_error_upper.size]
  ([data.measured_error_upper.size,
    data.source.size,
    data.time_measurement.size,
    data.time_measurement_error_upper.size,
    data.time_measurement_error_lower.size,
    data.time_measurement_width.size,
    data.time_measurement_width_error_upper.size,
    data.time_measurement_width_error_lower.size,
    data.local.size,
    data.rho_tor_norm.size,
    data.rho_tor_norm_error_upper.size,
    data.rho_tor_norm_error_lower.size,
    data.weight.size,
    data.weight_error_upper.size,
    data.weight_error_lower.size,
    data.reconstructed.size,
    data.reconstructed_error_upper.size,
    data.reconstructed_error_lower.size,
    data.chi_squared.size,
    data.chi_squared_error_upper.size,
    data.chi_squared_error_lower.size].all fun size =>
    size == 0 || coordinateSizesMatch size coordinates1) &&
  (data.measured_error_lower.size == 0 || coordinateSizesMatch data.measured_error_lower.size coordinates2)

def «core_profiles/profiles_1d/ion/density_fit».coordinatesValid (data : «core_profiles/profiles_1d/ion/density_fit») : Prop :=
  «core_profiles/profiles_1d/ion/density_fit».coordinatesValidBool data = true

instance (data : «core_profiles/profiles_1d/ion/density_fit») : Decidable («core_profiles/profiles_1d/ion/density_fit».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_1d/ion/density_fit».coordinatesValidBool data = true))

def «core_profiles/profiles_1d/ion/density_fit».isValid (data : «core_profiles/profiles_1d/ion/density_fit») : Prop :=
  «core_profiles/profiles_1d/ion/density_fit».coordinatesValid data

instance (data : «core_profiles/profiles_1d/ion/density_fit») : Decidable («core_profiles/profiles_1d/ion/density_fit».isValid data) := by
  unfold «core_profiles/profiles_1d/ion/density_fit».isValid
  infer_instance

def «core_profiles/profiles_1d/ion/state/density_fit».coordinatesValidBool (data : «core_profiles/profiles_1d/ion/state/density_fit») : Bool :=
  let coordinates1 := [data.measured.size]
  let coordinates2 := [data.measured_error_upper.size]
  ([data.measured_error_upper.size,
    data.source.size,
    data.time_measurement.size,
    data.time_measurement_error_upper.size,
    data.time_measurement_error_lower.size,
    data.time_measurement_width.size,
    data.time_measurement_width_error_upper.size,
    data.time_measurement_width_error_lower.size,
    data.local.size,
    data.rho_tor_norm.size,
    data.rho_tor_norm_error_upper.size,
    data.rho_tor_norm_error_lower.size,
    data.weight.size,
    data.weight_error_upper.size,
    data.weight_error_lower.size,
    data.reconstructed.size,
    data.reconstructed_error_upper.size,
    data.reconstructed_error_lower.size,
    data.chi_squared.size,
    data.chi_squared_error_upper.size,
    data.chi_squared_error_lower.size].all fun size =>
    size == 0 || coordinateSizesMatch size coordinates1) &&
  (data.measured_error_lower.size == 0 || coordinateSizesMatch data.measured_error_lower.size coordinates2)

def «core_profiles/profiles_1d/ion/state/density_fit».coordinatesValid (data : «core_profiles/profiles_1d/ion/state/density_fit») : Prop :=
  «core_profiles/profiles_1d/ion/state/density_fit».coordinatesValidBool data = true

instance (data : «core_profiles/profiles_1d/ion/state/density_fit») : Decidable («core_profiles/profiles_1d/ion/state/density_fit».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_1d/ion/state/density_fit».coordinatesValidBool data = true))

def «core_profiles/profiles_1d/ion/state/density_fit».isValid (data : «core_profiles/profiles_1d/ion/state/density_fit») : Prop :=
  «core_profiles/profiles_1d/ion/state/density_fit».coordinatesValid data

instance (data : «core_profiles/profiles_1d/ion/state/density_fit») : Decidable («core_profiles/profiles_1d/ion/state/density_fit».isValid data) := by
  unfold «core_profiles/profiles_1d/ion/state/density_fit».isValid
  infer_instance

def «core_profiles/profiles_1d/ion/state».coordinatesValidBool (data : «core_profiles/profiles_1d/ion/state») : Bool :=
  «core_profiles/profiles_1d/ion/state/density_fit».coordinatesValidBool data.density_fit.value

def «core_profiles/profiles_1d/ion/state».coordinatesValid (data : «core_profiles/profiles_1d/ion/state») : Prop :=
  «core_profiles/profiles_1d/ion/state».coordinatesValidBool data = true

instance (data : «core_profiles/profiles_1d/ion/state») : Decidable («core_profiles/profiles_1d/ion/state».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_1d/ion/state».coordinatesValidBool data = true))

def «core_profiles/profiles_1d/ion/state».isValid (data : «core_profiles/profiles_1d/ion/state») : Prop :=
  «core_profiles/profiles_1d/ion/state».coordinatesValid data

instance (data : «core_profiles/profiles_1d/ion/state») : Decidable («core_profiles/profiles_1d/ion/state».isValid data) := by
  unfold «core_profiles/profiles_1d/ion/state».isValid
  infer_instance

def «core_profiles/profiles_1d/ion».coordinatesValidBool (data : «core_profiles/profiles_1d/ion») : Bool :=
  «core_profiles/profiles_1d/ion/temperature_fit».coordinatesValidBool data.temperature_fit.value &&
  «core_profiles/profiles_1d/ion/density_fit».coordinatesValidBool data.density_fit.value &&
  data.state.toList.all «core_profiles/profiles_1d/ion/state».coordinatesValidBool

def «core_profiles/profiles_1d/ion».coordinatesValid (data : «core_profiles/profiles_1d/ion») : Prop :=
  «core_profiles/profiles_1d/ion».coordinatesValidBool data = true

instance (data : «core_profiles/profiles_1d/ion») : Decidable («core_profiles/profiles_1d/ion».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_1d/ion».coordinatesValidBool data = true))

def «core_profiles/profiles_1d/ion».isValid (data : «core_profiles/profiles_1d/ion») : Prop :=
  «core_profiles/profiles_1d/ion».coordinatesValid data

instance (data : «core_profiles/profiles_1d/ion») : Decidable («core_profiles/profiles_1d/ion».isValid data) := by
  unfold «core_profiles/profiles_1d/ion».isValid
  infer_instance

def «core_profiles/profiles_1d/t_i_average_fit».coordinatesValidBool (data : «core_profiles/profiles_1d/t_i_average_fit») : Bool :=
  let coordinates1 := [data.measured.size]
  let coordinates2 := [data.measured_error_upper.size]
  ([data.measured_error_upper.size,
    data.source.size,
    data.time_measurement.size,
    data.time_measurement_error_upper.size,
    data.time_measurement_error_lower.size,
    data.time_measurement_width.size,
    data.time_measurement_width_error_upper.size,
    data.time_measurement_width_error_lower.size,
    data.local.size,
    data.rho_tor_norm.size,
    data.rho_tor_norm_error_upper.size,
    data.rho_tor_norm_error_lower.size,
    data.weight.size,
    data.weight_error_upper.size,
    data.weight_error_lower.size,
    data.reconstructed.size,
    data.reconstructed_error_upper.size,
    data.reconstructed_error_lower.size,
    data.chi_squared.size,
    data.chi_squared_error_upper.size,
    data.chi_squared_error_lower.size].all fun size =>
    size == 0 || coordinateSizesMatch size coordinates1) &&
  (data.measured_error_lower.size == 0 || coordinateSizesMatch data.measured_error_lower.size coordinates2)

def «core_profiles/profiles_1d/t_i_average_fit».coordinatesValid (data : «core_profiles/profiles_1d/t_i_average_fit») : Prop :=
  «core_profiles/profiles_1d/t_i_average_fit».coordinatesValidBool data = true

instance (data : «core_profiles/profiles_1d/t_i_average_fit») : Decidable («core_profiles/profiles_1d/t_i_average_fit».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_1d/t_i_average_fit».coordinatesValidBool data = true))

def «core_profiles/profiles_1d/t_i_average_fit».isValid (data : «core_profiles/profiles_1d/t_i_average_fit») : Prop :=
  «core_profiles/profiles_1d/t_i_average_fit».coordinatesValid data

instance (data : «core_profiles/profiles_1d/t_i_average_fit») : Decidable («core_profiles/profiles_1d/t_i_average_fit».isValid data) := by
  unfold «core_profiles/profiles_1d/t_i_average_fit».isValid
  infer_instance

def «core_profiles/profiles_1d/zeff_fit».coordinatesValidBool (data : «core_profiles/profiles_1d/zeff_fit») : Bool :=
  let coordinates1 := [data.measured.size]
  let coordinates2 := [data.measured_error_upper.size]
  ([data.measured_error_upper.size,
    data.source.size,
    data.time_measurement.size,
    data.time_measurement_error_upper.size,
    data.time_measurement_error_lower.size,
    data.time_measurement_width.size,
    data.time_measurement_width_error_upper.size,
    data.time_measurement_width_error_lower.size,
    data.local.size,
    data.rho_tor_norm.size,
    data.rho_tor_norm_error_upper.size,
    data.rho_tor_norm_error_lower.size,
    data.weight.size,
    data.weight_error_upper.size,
    data.weight_error_lower.size,
    data.reconstructed.size,
    data.reconstructed_error_upper.size,
    data.reconstructed_error_lower.size,
    data.chi_squared.size,
    data.chi_squared_error_upper.size,
    data.chi_squared_error_lower.size].all fun size =>
    size == 0 || coordinateSizesMatch size coordinates1) &&
  (data.measured_error_lower.size == 0 || coordinateSizesMatch data.measured_error_lower.size coordinates2)

def «core_profiles/profiles_1d/zeff_fit».coordinatesValid (data : «core_profiles/profiles_1d/zeff_fit») : Prop :=
  «core_profiles/profiles_1d/zeff_fit».coordinatesValidBool data = true

instance (data : «core_profiles/profiles_1d/zeff_fit») : Decidable («core_profiles/profiles_1d/zeff_fit».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_1d/zeff_fit».coordinatesValidBool data = true))

def «core_profiles/profiles_1d/zeff_fit».isValid (data : «core_profiles/profiles_1d/zeff_fit») : Prop :=
  «core_profiles/profiles_1d/zeff_fit».coordinatesValid data

instance (data : «core_profiles/profiles_1d/zeff_fit») : Decidable («core_profiles/profiles_1d/zeff_fit».isValid data) := by
  unfold «core_profiles/profiles_1d/zeff_fit».isValid
  infer_instance

def «core_profiles/profiles_1d».coordinatesValidBool (data : «core_profiles/profiles_1d») : Bool :=
  let coordinates1 := [data.grid.rho_tor_norm.size,
    data.grid.rho_tor.size,
    data.grid.psi.size,
    data.grid.volume.size,
    data.grid.area.size,
    data.grid.surface.size,
    data.grid.rho_pol_norm.size]
  ([data.electrons.temperature.size,
    data.electrons.temperature_error_upper.size,
    data.electrons.temperature_error_lower.size,
    data.electrons.density.size,
    data.electrons.density_error_upper.size,
    data.electrons.density_error_lower.size,
    data.electrons.density_thermal.size,
    data.electrons.density_thermal_error_upper.size,
    data.electrons.density_thermal_error_lower.size,
    data.electrons.density_fast.size,
    data.electrons.density_fast_error_upper.size,
    data.electrons.density_fast_error_lower.size,
    data.electrons.pressure.size,
    data.electrons.pressure_error_upper.size,
    data.electrons.pressure_error_lower.size,
    data.electrons.pressure_thermal.size,
    data.electrons.pressure_thermal_error_upper.size,
    data.electrons.pressure_thermal_error_lower.size,
    data.electrons.pressure_fast_perpendicular.size,
    data.electrons.pressure_fast_perpendicular_error_upper.size,
    data.electrons.pressure_fast_perpendicular_error_lower.size,
    data.electrons.pressure_fast_parallel.size,
    data.electrons.pressure_fast_parallel_error_upper.size,
    data.electrons.pressure_fast_parallel_error_lower.size,
    data.electrons.collisionality_norm.size,
    data.electrons.collisionality_norm_error_upper.size,
    data.electrons.collisionality_norm_error_lower.size,
    data.t_i_average.size,
    data.t_i_average_error_upper.size,
    data.t_i_average_error_lower.size,
    data.n_i_total_over_n_e.size,
    data.n_i_total_over_n_e_error_upper.size,
    data.n_i_total_over_n_e_error_lower.size,
    data.n_i_thermal_total.size,
    data.n_i_thermal_total_error_upper.size,
    data.n_i_thermal_total_error_lower.size,
    data.momentum_phi.size,
    data.momentum_phi_error_upper.size,
    data.momentum_phi_error_lower.size,
    data.zeff.size,
    data.zeff_error_upper.size,
    data.zeff_error_lower.size,
    data.pressure_ion_total.size,
    data.pressure_ion_total_error_upper.size,
    data.pressure_ion_total_error_lower.size,
    data.pressure_thermal.size,
    data.pressure_thermal_error_upper.size,
    data.pressure_thermal_error_lower.size,
    data.pressure_perpendicular.size,
    data.pressure_perpendicular_error_upper.size,
    data.pressure_perpendicular_error_lower.size,
    data.pressure_parallel.size,
    data.pressure_parallel_error_upper.size,
    data.pressure_parallel_error_lower.size,
    data.j_total.size,
    data.j_total_error_upper.size,
    data.j_total_error_lower.size,
    data.current_parallel_inside.size,
    data.current_parallel_inside_error_upper.size,
    data.current_parallel_inside_error_lower.size,
    data.j_phi.size,
    data.j_phi_error_upper.size,
    data.j_phi_error_lower.size,
    data.j_ohmic.size,
    data.j_ohmic_error_upper.size,
    data.j_ohmic_error_lower.size,
    data.j_non_inductive.size,
    data.j_non_inductive_error_upper.size,
    data.j_non_inductive_error_lower.size,
    data.j_bootstrap.size,
    data.j_bootstrap_error_upper.size,
    data.j_bootstrap_error_lower.size,
    data.conductivity_parallel.size,
    data.conductivity_parallel_error_upper.size,
    data.conductivity_parallel_error_lower.size,
    data.e_field.value.radial.size,
    data.e_field.value.radial_error_upper.size,
    data.e_field.value.radial_error_lower.size,
    data.e_field.value.diamagnetic.size,
    data.e_field.value.diamagnetic_error_upper.size,
    data.e_field.value.diamagnetic_error_lower.size,
    data.e_field.value.parallel.size,
    data.e_field.value.parallel_error_upper.size,
    data.e_field.value.parallel_error_lower.size,
    data.e_field.value.poloidal.size,
    data.e_field.value.poloidal_error_upper.size,
    data.e_field.value.poloidal_error_lower.size,
    data.e_field.value.toroidal.size,
    data.e_field.value.toroidal_error_upper.size,
    data.e_field.value.toroidal_error_lower.size,
    data.phi_potential.size,
    data.phi_potential_error_upper.size,
    data.phi_potential_error_lower.size,
    data.rotation_frequency_tor_sonic.size,
    data.rotation_frequency_tor_sonic_error_upper.size,
    data.rotation_frequency_tor_sonic_error_lower.size,
    data.q.size,
    data.q_error_upper.size,
    data.q_error_lower.size,
    data.magnetic_shear.size,
    data.magnetic_shear_error_upper.size,
    data.magnetic_shear_error_lower.size].all fun size =>
    size == 0 || coordinateSizesMatch size coordinates1) &&
  (data.ion.toList.all fun item1 =>
    ([item1.z_ion_1d.size,
    item1.z_ion_1d_error_upper.size,
    item1.z_ion_1d_error_lower.size,
    item1.z_ion_square_1d.size,
    item1.z_ion_square_1d_error_upper.size,
    item1.z_ion_square_1d_error_lower.size,
    item1.temperature.size,
    item1.temperature_error_upper.size,
    item1.temperature_error_lower.size,
    item1.density.size,
    item1.density_error_upper.size,
    item1.density_error_lower.size,
    item1.density_thermal.size,
    item1.density_thermal_error_upper.size,
    item1.density_thermal_error_lower.size,
    item1.density_fast.size,
    item1.density_fast_error_upper.size,
    item1.density_fast_error_lower.size,
    item1.pressure.size,
    item1.pressure_error_upper.size,
    item1.pressure_error_lower.size,
    item1.pressure_thermal.size,
    item1.pressure_thermal_error_upper.size,
    item1.pressure_thermal_error_lower.size,
    item1.pressure_fast_perpendicular.size,
    item1.pressure_fast_perpendicular_error_upper.size,
    item1.pressure_fast_perpendicular_error_lower.size,
    item1.pressure_fast_parallel.size,
    item1.pressure_fast_parallel_error_upper.size,
    item1.pressure_fast_parallel_error_lower.size,
    item1.rotation_frequency_tor.size,
    item1.rotation_frequency_tor_error_upper.size,
    item1.rotation_frequency_tor_error_lower.size,
    item1.velocity.value.radial.size,
    item1.velocity.value.radial_error_upper.size,
    item1.velocity.value.radial_error_lower.size,
    item1.velocity.value.diamagnetic.size,
    item1.velocity.value.diamagnetic_error_upper.size,
    item1.velocity.value.diamagnetic_error_lower.size,
    item1.velocity.value.parallel.size,
    item1.velocity.value.parallel_error_upper.size,
    item1.velocity.value.parallel_error_lower.size,
    item1.velocity.value.poloidal.size,
    item1.velocity.value.poloidal_error_upper.size,
    item1.velocity.value.poloidal_error_lower.size,
    item1.velocity.value.toroidal.size,
    item1.velocity.value.toroidal_error_upper.size,
    item1.velocity.value.toroidal_error_lower.size].all fun size =>
    size == 0 || coordinateSizesMatch size coordinates1)) &&
  (data.ion.toList.all fun item1 =>
    (item1.state.toList.all fun item2 =>
    ([item2.z_average_1d.size,
    item2.z_average_1d_error_upper.size,
    item2.z_average_1d_error_lower.size,
    item2.z_average_square_1d.size,
    item2.z_average_square_1d_error_upper.size,
    item2.z_average_square_1d_error_lower.size,
    item2.rotation_frequency_tor.size,
    item2.rotation_frequency_tor_error_upper.size,
    item2.rotation_frequency_tor_error_lower.size,
    item2.velocity.value.radial.size,
    item2.velocity.value.radial_error_upper.size,
    item2.velocity.value.radial_error_lower.size,
    item2.velocity.value.diamagnetic.size,
    item2.velocity.value.diamagnetic_error_upper.size,
    item2.velocity.value.diamagnetic_error_lower.size,
    item2.velocity.value.parallel.size,
    item2.velocity.value.parallel_error_upper.size,
    item2.velocity.value.parallel_error_lower.size,
    item2.velocity.value.poloidal.size,
    item2.velocity.value.poloidal_error_upper.size,
    item2.velocity.value.poloidal_error_lower.size,
    item2.velocity.value.toroidal.size,
    item2.velocity.value.toroidal_error_upper.size,
    item2.velocity.value.toroidal_error_lower.size,
    item2.temperature.size,
    item2.temperature_error_upper.size,
    item2.temperature_error_lower.size,
    item2.density.size,
    item2.density_error_upper.size,
    item2.density_error_lower.size,
    item2.density_thermal.size,
    item2.density_thermal_error_upper.size,
    item2.density_thermal_error_lower.size,
    item2.density_fast.size,
    item2.density_fast_error_upper.size,
    item2.density_fast_error_lower.size,
    item2.pressure.size,
    item2.pressure_error_upper.size,
    item2.pressure_error_lower.size,
    item2.pressure_thermal.size,
    item2.pressure_thermal_error_upper.size,
    item2.pressure_thermal_error_lower.size,
    item2.pressure_fast_perpendicular.size,
    item2.pressure_fast_perpendicular_error_upper.size,
    item2.pressure_fast_perpendicular_error_lower.size,
    item2.pressure_fast_parallel.size,
    item2.pressure_fast_parallel_error_upper.size,
    item2.pressure_fast_parallel_error_lower.size].all fun size =>
    size == 0 || coordinateSizesMatch size coordinates1))) &&
  (data.neutral.toList.all fun item1 =>
    ([item1.temperature.size,
    item1.temperature_error_upper.size,
    item1.temperature_error_lower.size,
    item1.density.size,
    item1.density_error_upper.size,
    item1.density_error_lower.size,
    item1.density_thermal.size,
    item1.density_thermal_error_upper.size,
    item1.density_thermal_error_lower.size,
    item1.density_fast.size,
    item1.density_fast_error_upper.size,
    item1.density_fast_error_lower.size,
    item1.pressure.size,
    item1.pressure_error_upper.size,
    item1.pressure_error_lower.size,
    item1.pressure_thermal.size,
    item1.pressure_thermal_error_upper.size,
    item1.pressure_thermal_error_lower.size,
    item1.pressure_fast_perpendicular.size,
    item1.pressure_fast_perpendicular_error_upper.size,
    item1.pressure_fast_perpendicular_error_lower.size,
    item1.pressure_fast_parallel.size,
    item1.pressure_fast_parallel_error_upper.size,
    item1.pressure_fast_parallel_error_lower.size].all fun size =>
    size == 0 || coordinateSizesMatch size coordinates1)) &&
  (data.neutral.toList.all fun item1 =>
    (item1.state.toList.all fun item2 =>
    ([item2.temperature.size,
    item2.temperature_error_upper.size,
    item2.temperature_error_lower.size,
    item2.density.size,
    item2.density_error_upper.size,
    item2.density_error_lower.size,
    item2.density_thermal.size,
    item2.density_thermal_error_upper.size,
    item2.density_thermal_error_lower.size,
    item2.density_fast.size,
    item2.density_fast_error_upper.size,
    item2.density_fast_error_lower.size,
    item2.pressure.size,
    item2.pressure_error_upper.size,
    item2.pressure_error_lower.size,
    item2.pressure_thermal.size,
    item2.pressure_thermal_error_upper.size,
    item2.pressure_thermal_error_lower.size,
    item2.pressure_fast_perpendicular.size,
    item2.pressure_fast_perpendicular_error_upper.size,
    item2.pressure_fast_perpendicular_error_lower.size,
    item2.pressure_fast_parallel.size,
    item2.pressure_fast_parallel_error_upper.size,
    item2.pressure_fast_parallel_error_lower.size].all fun size =>
    size == 0 || coordinateSizesMatch size coordinates1))) &&
  «core_profiles/profiles_1d/grid».coordinatesValidBool data.grid &&
  «core_profiles/profiles_1d/electrons».coordinatesValidBool data.electrons &&
  data.ion.toList.all «core_profiles/profiles_1d/ion».coordinatesValidBool &&
  «core_profiles/profiles_1d/t_i_average_fit».coordinatesValidBool data.t_i_average_fit.value &&
  «core_profiles/profiles_1d/zeff_fit».coordinatesValidBool data.zeff_fit.value

def «core_profiles/profiles_1d».coordinatesValid (data : «core_profiles/profiles_1d») : Prop :=
  «core_profiles/profiles_1d».coordinatesValidBool data = true

instance (data : «core_profiles/profiles_1d») : Decidable («core_profiles/profiles_1d».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_1d».coordinatesValidBool data = true))

def «core_profiles/profiles_1d».isValid (data : «core_profiles/profiles_1d») : Prop :=
  «core_profiles/profiles_1d».coordinatesValid data

instance (data : «core_profiles/profiles_1d») : Decidable («core_profiles/profiles_1d».isValid data) := by
  unfold «core_profiles/profiles_1d».isValid
  infer_instance

def «core_profiles/profiles_2d/grid».coordinatesValidBool (data : «core_profiles/profiles_2d/grid») : Bool :=
  -- Matrix pairs contain storage length and the dimension being checked.
  let coordinates1 := [data.dim1.size]
  let coordinates2 := [data.dim1_error_upper.size]
  let coordinates3 := [data.dim2.size]
  let coordinates4 := [data.dim2_error_upper.size]
  (data.dim1_error_upper.size == 0 || coordinateSizesMatch data.dim1_error_upper.size coordinates1) &&
  (data.dim1_error_lower.size == 0 || coordinateSizesMatch data.dim1_error_lower.size coordinates2) &&
  (data.dim2_error_upper.size == 0 || coordinateSizesMatch data.dim2_error_upper.size coordinates3) &&
  (data.dim2_error_lower.size == 0 || coordinateSizesMatch data.dim2_error_lower.size coordinates4) &&
  ([(data.volume_element.data.size, data.volume_element.rows),
    (data.volume_element_error_upper.data.size, data.volume_element_error_upper.rows),
    (data.volume_element_error_lower.data.size, data.volume_element_error_lower.rows)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates1) &&
  ([(data.volume_element.data.size, data.volume_element.cols),
    (data.volume_element_error_upper.data.size, data.volume_element_error_upper.cols),
    (data.volume_element_error_lower.data.size, data.volume_element_error_lower.cols)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates3)

def «core_profiles/profiles_2d/grid».storageValidBool (data : «core_profiles/profiles_2d/grid») : Bool :=
  data.volume_element.storageValid &&
  data.volume_element_error_upper.storageValid &&
  data.volume_element_error_lower.storageValid

def «core_profiles/profiles_2d/grid».coordinatesValid (data : «core_profiles/profiles_2d/grid») : Prop :=
  «core_profiles/profiles_2d/grid».coordinatesValidBool data = true

instance (data : «core_profiles/profiles_2d/grid») : Decidable («core_profiles/profiles_2d/grid».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_2d/grid».coordinatesValidBool data = true))

def «core_profiles/profiles_2d/grid».storageValid (data : «core_profiles/profiles_2d/grid») : Prop :=
  «core_profiles/profiles_2d/grid».storageValidBool data = true

instance (data : «core_profiles/profiles_2d/grid») : Decidable («core_profiles/profiles_2d/grid».storageValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_2d/grid».storageValidBool data = true))

def «core_profiles/profiles_2d/grid».isValid (data : «core_profiles/profiles_2d/grid») : Prop :=
  «core_profiles/profiles_2d/grid».coordinatesValid data ∧ «core_profiles/profiles_2d/grid».storageValid data

instance (data : «core_profiles/profiles_2d/grid») : Decidable («core_profiles/profiles_2d/grid».isValid data) := by
  unfold «core_profiles/profiles_2d/grid».isValid
  infer_instance

def «core_profiles/profiles_2d/ion/velocity».storageValidBool (data : «core_profiles/profiles_2d/ion/velocity») : Bool :=
  data.radial.storageValid &&
  data.radial_error_upper.storageValid &&
  data.radial_error_lower.storageValid &&
  data.diamagnetic.storageValid &&
  data.diamagnetic_error_upper.storageValid &&
  data.diamagnetic_error_lower.storageValid &&
  data.parallel.storageValid &&
  data.parallel_error_upper.storageValid &&
  data.parallel_error_lower.storageValid &&
  data.poloidal.storageValid &&
  data.poloidal_error_upper.storageValid &&
  data.poloidal_error_lower.storageValid &&
  data.toroidal.storageValid &&
  data.toroidal_error_upper.storageValid &&
  data.toroidal_error_lower.storageValid

def «core_profiles/profiles_2d/ion/velocity».storageValid (data : «core_profiles/profiles_2d/ion/velocity») : Prop :=
  «core_profiles/profiles_2d/ion/velocity».storageValidBool data = true

instance (data : «core_profiles/profiles_2d/ion/velocity») : Decidable («core_profiles/profiles_2d/ion/velocity».storageValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_2d/ion/velocity».storageValidBool data = true))

def «core_profiles/profiles_2d/ion/velocity».isValid (data : «core_profiles/profiles_2d/ion/velocity») : Prop :=
  «core_profiles/profiles_2d/ion/velocity».storageValid data

instance (data : «core_profiles/profiles_2d/ion/velocity») : Decidable («core_profiles/profiles_2d/ion/velocity».isValid data) := by
  unfold «core_profiles/profiles_2d/ion/velocity».isValid
  infer_instance

def «core_profiles/profiles_2d/ion/state».storageValidBool (data : «core_profiles/profiles_2d/ion/state») : Bool :=
  data.rotation_frequency_tor.storageValid &&
  data.rotation_frequency_tor_error_upper.storageValid &&
  data.rotation_frequency_tor_error_lower.storageValid &&
  data.temperature.storageValid &&
  data.temperature_error_upper.storageValid &&
  data.temperature_error_lower.storageValid &&
  data.density.storageValid &&
  data.density_error_upper.storageValid &&
  data.density_error_lower.storageValid &&
  data.density_thermal.storageValid &&
  data.density_thermal_error_upper.storageValid &&
  data.density_thermal_error_lower.storageValid &&
  data.density_fast.storageValid &&
  data.density_fast_error_upper.storageValid &&
  data.density_fast_error_lower.storageValid &&
  data.pressure.storageValid &&
  data.pressure_error_upper.storageValid &&
  data.pressure_error_lower.storageValid &&
  data.pressure_thermal.storageValid &&
  data.pressure_thermal_error_upper.storageValid &&
  data.pressure_thermal_error_lower.storageValid &&
  data.pressure_fast_perpendicular.storageValid &&
  data.pressure_fast_perpendicular_error_upper.storageValid &&
  data.pressure_fast_perpendicular_error_lower.storageValid &&
  data.pressure_fast_parallel.storageValid &&
  data.pressure_fast_parallel_error_upper.storageValid &&
  data.pressure_fast_parallel_error_lower.storageValid

def «core_profiles/profiles_2d/ion/state».storageValid (data : «core_profiles/profiles_2d/ion/state») : Prop :=
  «core_profiles/profiles_2d/ion/state».storageValidBool data = true

instance (data : «core_profiles/profiles_2d/ion/state») : Decidable («core_profiles/profiles_2d/ion/state».storageValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_2d/ion/state».storageValidBool data = true))

def «core_profiles/profiles_2d/ion/state».isValid (data : «core_profiles/profiles_2d/ion/state») : Prop :=
  «core_profiles/profiles_2d/ion/state».storageValid data

instance (data : «core_profiles/profiles_2d/ion/state») : Decidable («core_profiles/profiles_2d/ion/state».isValid data) := by
  unfold «core_profiles/profiles_2d/ion/state».isValid
  infer_instance

def «core_profiles/profiles_2d/ion».storageValidBool (data : «core_profiles/profiles_2d/ion») : Bool :=
  data.temperature.storageValid &&
  data.temperature_error_upper.storageValid &&
  data.temperature_error_lower.storageValid &&
  data.density.storageValid &&
  data.density_error_upper.storageValid &&
  data.density_error_lower.storageValid &&
  data.density_thermal.storageValid &&
  data.density_thermal_error_upper.storageValid &&
  data.density_thermal_error_lower.storageValid &&
  data.density_fast.storageValid &&
  data.density_fast_error_upper.storageValid &&
  data.density_fast_error_lower.storageValid &&
  data.pressure.storageValid &&
  data.pressure_error_upper.storageValid &&
  data.pressure_error_lower.storageValid &&
  data.pressure_thermal.storageValid &&
  data.pressure_thermal_error_upper.storageValid &&
  data.pressure_thermal_error_lower.storageValid &&
  data.pressure_fast_perpendicular.storageValid &&
  data.pressure_fast_perpendicular_error_upper.storageValid &&
  data.pressure_fast_perpendicular_error_lower.storageValid &&
  data.pressure_fast_parallel.storageValid &&
  data.pressure_fast_parallel_error_upper.storageValid &&
  data.pressure_fast_parallel_error_lower.storageValid &&
  data.rotation_frequency_tor.storageValid &&
  data.rotation_frequency_tor_error_upper.storageValid &&
  data.rotation_frequency_tor_error_lower.storageValid &&
  «core_profiles/profiles_2d/ion/velocity».storageValidBool data.velocity.value &&
  data.state.toList.all «core_profiles/profiles_2d/ion/state».storageValidBool

def «core_profiles/profiles_2d/ion».storageValid (data : «core_profiles/profiles_2d/ion») : Prop :=
  «core_profiles/profiles_2d/ion».storageValidBool data = true

instance (data : «core_profiles/profiles_2d/ion») : Decidable («core_profiles/profiles_2d/ion».storageValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_2d/ion».storageValidBool data = true))

def «core_profiles/profiles_2d/ion».isValid (data : «core_profiles/profiles_2d/ion») : Prop :=
  «core_profiles/profiles_2d/ion».storageValid data

instance (data : «core_profiles/profiles_2d/ion») : Decidable («core_profiles/profiles_2d/ion».isValid data) := by
  unfold «core_profiles/profiles_2d/ion».isValid
  infer_instance

def «core_profiles/profiles_2d».coordinatesValidBool (data : «core_profiles/profiles_2d») : Bool :=
  -- Matrix pairs contain storage length and the dimension being checked.
  let coordinates1 := [data.grid.dim1.size]
  let coordinates2 := [data.grid.dim2.size]
  (data.ion.toList.all fun item1 =>
    ([(item1.temperature.data.size, item1.temperature.rows),
    (item1.temperature_error_upper.data.size, item1.temperature_error_upper.rows),
    (item1.temperature_error_lower.data.size, item1.temperature_error_lower.rows),
    (item1.density.data.size, item1.density.rows),
    (item1.density_error_upper.data.size, item1.density_error_upper.rows),
    (item1.density_error_lower.data.size, item1.density_error_lower.rows),
    (item1.density_thermal.data.size, item1.density_thermal.rows),
    (item1.density_thermal_error_upper.data.size, item1.density_thermal_error_upper.rows),
    (item1.density_thermal_error_lower.data.size, item1.density_thermal_error_lower.rows),
    (item1.density_fast.data.size, item1.density_fast.rows),
    (item1.density_fast_error_upper.data.size, item1.density_fast_error_upper.rows),
    (item1.density_fast_error_lower.data.size, item1.density_fast_error_lower.rows),
    (item1.pressure.data.size, item1.pressure.rows),
    (item1.pressure_error_upper.data.size, item1.pressure_error_upper.rows),
    (item1.pressure_error_lower.data.size, item1.pressure_error_lower.rows),
    (item1.pressure_thermal.data.size, item1.pressure_thermal.rows),
    (item1.pressure_thermal_error_upper.data.size, item1.pressure_thermal_error_upper.rows),
    (item1.pressure_thermal_error_lower.data.size, item1.pressure_thermal_error_lower.rows),
    (item1.pressure_fast_perpendicular.data.size, item1.pressure_fast_perpendicular.rows),
    (item1.pressure_fast_perpendicular_error_upper.data.size, item1.pressure_fast_perpendicular_error_upper.rows),
    (item1.pressure_fast_perpendicular_error_lower.data.size, item1.pressure_fast_perpendicular_error_lower.rows),
    (item1.pressure_fast_parallel.data.size, item1.pressure_fast_parallel.rows),
    (item1.pressure_fast_parallel_error_upper.data.size, item1.pressure_fast_parallel_error_upper.rows),
    (item1.pressure_fast_parallel_error_lower.data.size, item1.pressure_fast_parallel_error_lower.rows),
    (item1.rotation_frequency_tor.data.size, item1.rotation_frequency_tor.rows),
    (item1.rotation_frequency_tor_error_upper.data.size, item1.rotation_frequency_tor_error_upper.rows),
    (item1.rotation_frequency_tor_error_lower.data.size, item1.rotation_frequency_tor_error_lower.rows),
    (item1.velocity.value.radial.data.size, item1.velocity.value.radial.rows),
    (item1.velocity.value.radial_error_upper.data.size, item1.velocity.value.radial_error_upper.rows),
    (item1.velocity.value.radial_error_lower.data.size, item1.velocity.value.radial_error_lower.rows),
    (item1.velocity.value.diamagnetic.data.size, item1.velocity.value.diamagnetic.rows),
    (item1.velocity.value.diamagnetic_error_upper.data.size, item1.velocity.value.diamagnetic_error_upper.rows),
    (item1.velocity.value.diamagnetic_error_lower.data.size, item1.velocity.value.diamagnetic_error_lower.rows),
    (item1.velocity.value.parallel.data.size, item1.velocity.value.parallel.rows),
    (item1.velocity.value.parallel_error_upper.data.size, item1.velocity.value.parallel_error_upper.rows),
    (item1.velocity.value.parallel_error_lower.data.size, item1.velocity.value.parallel_error_lower.rows),
    (item1.velocity.value.poloidal.data.size, item1.velocity.value.poloidal.rows),
    (item1.velocity.value.poloidal_error_upper.data.size, item1.velocity.value.poloidal_error_upper.rows),
    (item1.velocity.value.poloidal_error_lower.data.size, item1.velocity.value.poloidal_error_lower.rows),
    (item1.velocity.value.toroidal.data.size, item1.velocity.value.toroidal.rows),
    (item1.velocity.value.toroidal_error_upper.data.size, item1.velocity.value.toroidal_error_upper.rows),
    (item1.velocity.value.toroidal_error_lower.data.size, item1.velocity.value.toroidal_error_lower.rows)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates1)) &&
  (data.ion.toList.all fun item1 =>
    ([(item1.temperature.data.size, item1.temperature.cols),
    (item1.temperature_error_upper.data.size, item1.temperature_error_upper.cols),
    (item1.temperature_error_lower.data.size, item1.temperature_error_lower.cols),
    (item1.density.data.size, item1.density.cols),
    (item1.density_error_upper.data.size, item1.density_error_upper.cols),
    (item1.density_error_lower.data.size, item1.density_error_lower.cols),
    (item1.density_thermal.data.size, item1.density_thermal.cols),
    (item1.density_thermal_error_upper.data.size, item1.density_thermal_error_upper.cols),
    (item1.density_thermal_error_lower.data.size, item1.density_thermal_error_lower.cols),
    (item1.density_fast.data.size, item1.density_fast.cols),
    (item1.density_fast_error_upper.data.size, item1.density_fast_error_upper.cols),
    (item1.density_fast_error_lower.data.size, item1.density_fast_error_lower.cols),
    (item1.pressure.data.size, item1.pressure.cols),
    (item1.pressure_error_upper.data.size, item1.pressure_error_upper.cols),
    (item1.pressure_error_lower.data.size, item1.pressure_error_lower.cols),
    (item1.pressure_thermal.data.size, item1.pressure_thermal.cols),
    (item1.pressure_thermal_error_upper.data.size, item1.pressure_thermal_error_upper.cols),
    (item1.pressure_thermal_error_lower.data.size, item1.pressure_thermal_error_lower.cols),
    (item1.pressure_fast_perpendicular.data.size, item1.pressure_fast_perpendicular.cols),
    (item1.pressure_fast_perpendicular_error_upper.data.size, item1.pressure_fast_perpendicular_error_upper.cols),
    (item1.pressure_fast_perpendicular_error_lower.data.size, item1.pressure_fast_perpendicular_error_lower.cols),
    (item1.pressure_fast_parallel.data.size, item1.pressure_fast_parallel.cols),
    (item1.pressure_fast_parallel_error_upper.data.size, item1.pressure_fast_parallel_error_upper.cols),
    (item1.pressure_fast_parallel_error_lower.data.size, item1.pressure_fast_parallel_error_lower.cols),
    (item1.rotation_frequency_tor.data.size, item1.rotation_frequency_tor.cols),
    (item1.rotation_frequency_tor_error_upper.data.size, item1.rotation_frequency_tor_error_upper.cols),
    (item1.rotation_frequency_tor_error_lower.data.size, item1.rotation_frequency_tor_error_lower.cols),
    (item1.velocity.value.radial.data.size, item1.velocity.value.radial.cols),
    (item1.velocity.value.radial_error_upper.data.size, item1.velocity.value.radial_error_upper.cols),
    (item1.velocity.value.radial_error_lower.data.size, item1.velocity.value.radial_error_lower.cols),
    (item1.velocity.value.diamagnetic.data.size, item1.velocity.value.diamagnetic.cols),
    (item1.velocity.value.diamagnetic_error_upper.data.size, item1.velocity.value.diamagnetic_error_upper.cols),
    (item1.velocity.value.diamagnetic_error_lower.data.size, item1.velocity.value.diamagnetic_error_lower.cols),
    (item1.velocity.value.parallel.data.size, item1.velocity.value.parallel.cols),
    (item1.velocity.value.parallel_error_upper.data.size, item1.velocity.value.parallel_error_upper.cols),
    (item1.velocity.value.parallel_error_lower.data.size, item1.velocity.value.parallel_error_lower.cols),
    (item1.velocity.value.poloidal.data.size, item1.velocity.value.poloidal.cols),
    (item1.velocity.value.poloidal_error_upper.data.size, item1.velocity.value.poloidal_error_upper.cols),
    (item1.velocity.value.poloidal_error_lower.data.size, item1.velocity.value.poloidal_error_lower.cols),
    (item1.velocity.value.toroidal.data.size, item1.velocity.value.toroidal.cols),
    (item1.velocity.value.toroidal_error_upper.data.size, item1.velocity.value.toroidal_error_upper.cols),
    (item1.velocity.value.toroidal_error_lower.data.size, item1.velocity.value.toroidal_error_lower.cols)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates2)) &&
  (data.ion.toList.all fun item1 =>
    (item1.state.toList.all fun item2 =>
    ([(item2.rotation_frequency_tor.data.size, item2.rotation_frequency_tor.rows),
    (item2.rotation_frequency_tor_error_upper.data.size, item2.rotation_frequency_tor_error_upper.rows),
    (item2.rotation_frequency_tor_error_lower.data.size, item2.rotation_frequency_tor_error_lower.rows),
    (item2.temperature.data.size, item2.temperature.rows),
    (item2.temperature_error_upper.data.size, item2.temperature_error_upper.rows),
    (item2.temperature_error_lower.data.size, item2.temperature_error_lower.rows),
    (item2.density.data.size, item2.density.rows),
    (item2.density_error_upper.data.size, item2.density_error_upper.rows),
    (item2.density_error_lower.data.size, item2.density_error_lower.rows),
    (item2.density_thermal.data.size, item2.density_thermal.rows),
    (item2.density_thermal_error_upper.data.size, item2.density_thermal_error_upper.rows),
    (item2.density_thermal_error_lower.data.size, item2.density_thermal_error_lower.rows),
    (item2.density_fast.data.size, item2.density_fast.rows),
    (item2.density_fast_error_upper.data.size, item2.density_fast_error_upper.rows),
    (item2.density_fast_error_lower.data.size, item2.density_fast_error_lower.rows),
    (item2.pressure.data.size, item2.pressure.rows),
    (item2.pressure_error_upper.data.size, item2.pressure_error_upper.rows),
    (item2.pressure_error_lower.data.size, item2.pressure_error_lower.rows),
    (item2.pressure_thermal.data.size, item2.pressure_thermal.rows),
    (item2.pressure_thermal_error_upper.data.size, item2.pressure_thermal_error_upper.rows),
    (item2.pressure_thermal_error_lower.data.size, item2.pressure_thermal_error_lower.rows),
    (item2.pressure_fast_perpendicular.data.size, item2.pressure_fast_perpendicular.rows),
    (item2.pressure_fast_perpendicular_error_upper.data.size, item2.pressure_fast_perpendicular_error_upper.rows),
    (item2.pressure_fast_perpendicular_error_lower.data.size, item2.pressure_fast_perpendicular_error_lower.rows),
    (item2.pressure_fast_parallel.data.size, item2.pressure_fast_parallel.rows),
    (item2.pressure_fast_parallel_error_upper.data.size, item2.pressure_fast_parallel_error_upper.rows),
    (item2.pressure_fast_parallel_error_lower.data.size, item2.pressure_fast_parallel_error_lower.rows)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates1))) &&
  (data.ion.toList.all fun item1 =>
    (item1.state.toList.all fun item2 =>
    ([(item2.rotation_frequency_tor.data.size, item2.rotation_frequency_tor.cols),
    (item2.rotation_frequency_tor_error_upper.data.size, item2.rotation_frequency_tor_error_upper.cols),
    (item2.rotation_frequency_tor_error_lower.data.size, item2.rotation_frequency_tor_error_lower.cols),
    (item2.temperature.data.size, item2.temperature.cols),
    (item2.temperature_error_upper.data.size, item2.temperature_error_upper.cols),
    (item2.temperature_error_lower.data.size, item2.temperature_error_lower.cols),
    (item2.density.data.size, item2.density.cols),
    (item2.density_error_upper.data.size, item2.density_error_upper.cols),
    (item2.density_error_lower.data.size, item2.density_error_lower.cols),
    (item2.density_thermal.data.size, item2.density_thermal.cols),
    (item2.density_thermal_error_upper.data.size, item2.density_thermal_error_upper.cols),
    (item2.density_thermal_error_lower.data.size, item2.density_thermal_error_lower.cols),
    (item2.density_fast.data.size, item2.density_fast.cols),
    (item2.density_fast_error_upper.data.size, item2.density_fast_error_upper.cols),
    (item2.density_fast_error_lower.data.size, item2.density_fast_error_lower.cols),
    (item2.pressure.data.size, item2.pressure.cols),
    (item2.pressure_error_upper.data.size, item2.pressure_error_upper.cols),
    (item2.pressure_error_lower.data.size, item2.pressure_error_lower.cols),
    (item2.pressure_thermal.data.size, item2.pressure_thermal.cols),
    (item2.pressure_thermal_error_upper.data.size, item2.pressure_thermal_error_upper.cols),
    (item2.pressure_thermal_error_lower.data.size, item2.pressure_thermal_error_lower.cols),
    (item2.pressure_fast_perpendicular.data.size, item2.pressure_fast_perpendicular.cols),
    (item2.pressure_fast_perpendicular_error_upper.data.size, item2.pressure_fast_perpendicular_error_upper.cols),
    (item2.pressure_fast_perpendicular_error_lower.data.size, item2.pressure_fast_perpendicular_error_lower.cols),
    (item2.pressure_fast_parallel.data.size, item2.pressure_fast_parallel.cols),
    (item2.pressure_fast_parallel_error_upper.data.size, item2.pressure_fast_parallel_error_upper.cols),
    (item2.pressure_fast_parallel_error_lower.data.size, item2.pressure_fast_parallel_error_lower.cols)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates2))) &&
  ([(data.t_i_average.data.size, data.t_i_average.rows),
    (data.t_i_average_error_upper.data.size, data.t_i_average_error_upper.rows),
    (data.t_i_average_error_lower.data.size, data.t_i_average_error_lower.rows),
    (data.n_i_total_over_n_e.data.size, data.n_i_total_over_n_e.rows),
    (data.n_i_total_over_n_e_error_upper.data.size, data.n_i_total_over_n_e_error_upper.rows),
    (data.n_i_total_over_n_e_error_lower.data.size, data.n_i_total_over_n_e_error_lower.rows),
    (data.n_i_thermal_total.data.size, data.n_i_thermal_total.rows),
    (data.n_i_thermal_total_error_upper.data.size, data.n_i_thermal_total_error_upper.rows),
    (data.n_i_thermal_total_error_lower.data.size, data.n_i_thermal_total_error_lower.rows),
    (data.momentum_phi.data.size, data.momentum_phi.rows),
    (data.momentum_phi_error_upper.data.size, data.momentum_phi_error_upper.rows),
    (data.momentum_phi_error_lower.data.size, data.momentum_phi_error_lower.rows),
    (data.zeff.data.size, data.zeff.rows),
    (data.zeff_error_upper.data.size, data.zeff_error_upper.rows),
    (data.zeff_error_lower.data.size, data.zeff_error_lower.rows),
    (data.pressure_ion_total.data.size, data.pressure_ion_total.rows),
    (data.pressure_ion_total_error_upper.data.size, data.pressure_ion_total_error_upper.rows),
    (data.pressure_ion_total_error_lower.data.size, data.pressure_ion_total_error_lower.rows),
    (data.pressure_thermal.data.size, data.pressure_thermal.rows),
    (data.pressure_thermal_error_upper.data.size, data.pressure_thermal_error_upper.rows),
    (data.pressure_thermal_error_lower.data.size, data.pressure_thermal_error_lower.rows),
    (data.pressure_perpendicular.data.size, data.pressure_perpendicular.rows),
    (data.pressure_perpendicular_error_upper.data.size, data.pressure_perpendicular_error_upper.rows),
    (data.pressure_perpendicular_error_lower.data.size, data.pressure_perpendicular_error_lower.rows),
    (data.pressure_parallel.data.size, data.pressure_parallel.rows),
    (data.pressure_parallel_error_upper.data.size, data.pressure_parallel_error_upper.rows),
    (data.pressure_parallel_error_lower.data.size, data.pressure_parallel_error_lower.rows)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates1) &&
  ([(data.t_i_average.data.size, data.t_i_average.cols),
    (data.t_i_average_error_upper.data.size, data.t_i_average_error_upper.cols),
    (data.t_i_average_error_lower.data.size, data.t_i_average_error_lower.cols),
    (data.n_i_total_over_n_e.data.size, data.n_i_total_over_n_e.cols),
    (data.n_i_total_over_n_e_error_upper.data.size, data.n_i_total_over_n_e_error_upper.cols),
    (data.n_i_total_over_n_e_error_lower.data.size, data.n_i_total_over_n_e_error_lower.cols),
    (data.n_i_thermal_total.data.size, data.n_i_thermal_total.cols),
    (data.n_i_thermal_total_error_upper.data.size, data.n_i_thermal_total_error_upper.cols),
    (data.n_i_thermal_total_error_lower.data.size, data.n_i_thermal_total_error_lower.cols),
    (data.momentum_phi.data.size, data.momentum_phi.cols),
    (data.momentum_phi_error_upper.data.size, data.momentum_phi_error_upper.cols),
    (data.momentum_phi_error_lower.data.size, data.momentum_phi_error_lower.cols),
    (data.zeff.data.size, data.zeff.cols),
    (data.zeff_error_upper.data.size, data.zeff_error_upper.cols),
    (data.zeff_error_lower.data.size, data.zeff_error_lower.cols),
    (data.pressure_ion_total.data.size, data.pressure_ion_total.cols),
    (data.pressure_ion_total_error_upper.data.size, data.pressure_ion_total_error_upper.cols),
    (data.pressure_ion_total_error_lower.data.size, data.pressure_ion_total_error_lower.cols),
    (data.pressure_thermal.data.size, data.pressure_thermal.cols),
    (data.pressure_thermal_error_upper.data.size, data.pressure_thermal_error_upper.cols),
    (data.pressure_thermal_error_lower.data.size, data.pressure_thermal_error_lower.cols),
    (data.pressure_perpendicular.data.size, data.pressure_perpendicular.cols),
    (data.pressure_perpendicular_error_upper.data.size, data.pressure_perpendicular_error_upper.cols),
    (data.pressure_perpendicular_error_lower.data.size, data.pressure_perpendicular_error_lower.cols),
    (data.pressure_parallel.data.size, data.pressure_parallel.cols),
    (data.pressure_parallel_error_upper.data.size, data.pressure_parallel_error_upper.cols),
    (data.pressure_parallel_error_lower.data.size, data.pressure_parallel_error_lower.cols)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates2) &&
  «core_profiles/profiles_2d/grid».coordinatesValidBool data.grid

def «core_profiles/profiles_2d».storageValidBool (data : «core_profiles/profiles_2d») : Bool :=
  «core_profiles/profiles_2d/grid».storageValidBool data.grid &&
  data.ion.toList.all «core_profiles/profiles_2d/ion».storageValidBool &&
  data.t_i_average.storageValid &&
  data.t_i_average_error_upper.storageValid &&
  data.t_i_average_error_lower.storageValid &&
  data.n_i_total_over_n_e.storageValid &&
  data.n_i_total_over_n_e_error_upper.storageValid &&
  data.n_i_total_over_n_e_error_lower.storageValid &&
  data.n_i_thermal_total.storageValid &&
  data.n_i_thermal_total_error_upper.storageValid &&
  data.n_i_thermal_total_error_lower.storageValid &&
  data.momentum_phi.storageValid &&
  data.momentum_phi_error_upper.storageValid &&
  data.momentum_phi_error_lower.storageValid &&
  data.zeff.storageValid &&
  data.zeff_error_upper.storageValid &&
  data.zeff_error_lower.storageValid &&
  data.pressure_ion_total.storageValid &&
  data.pressure_ion_total_error_upper.storageValid &&
  data.pressure_ion_total_error_lower.storageValid &&
  data.pressure_thermal.storageValid &&
  data.pressure_thermal_error_upper.storageValid &&
  data.pressure_thermal_error_lower.storageValid &&
  data.pressure_perpendicular.storageValid &&
  data.pressure_perpendicular_error_upper.storageValid &&
  data.pressure_perpendicular_error_lower.storageValid &&
  data.pressure_parallel.storageValid &&
  data.pressure_parallel_error_upper.storageValid &&
  data.pressure_parallel_error_lower.storageValid

def «core_profiles/profiles_2d».coordinatesValid (data : «core_profiles/profiles_2d») : Prop :=
  «core_profiles/profiles_2d».coordinatesValidBool data = true

instance (data : «core_profiles/profiles_2d») : Decidable («core_profiles/profiles_2d».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_2d».coordinatesValidBool data = true))

def «core_profiles/profiles_2d».storageValid (data : «core_profiles/profiles_2d») : Prop :=
  «core_profiles/profiles_2d».storageValidBool data = true

instance (data : «core_profiles/profiles_2d») : Decidable («core_profiles/profiles_2d».storageValid data) :=
  inferInstanceAs (Decidable («core_profiles/profiles_2d».storageValidBool data = true))

def «core_profiles/profiles_2d».isValid (data : «core_profiles/profiles_2d») : Prop :=
  «core_profiles/profiles_2d».coordinatesValid data ∧ «core_profiles/profiles_2d».storageValid data

instance (data : «core_profiles/profiles_2d») : Decidable («core_profiles/profiles_2d».isValid data) := by
  unfold «core_profiles/profiles_2d».isValid
  infer_instance

def «core_profiles/covariance».coordinatesValidBool (data : «core_profiles/covariance») : Bool :=
  -- Matrix pairs contain storage length and the dimension being checked.
  let coordinates1 := [data.rows_uri.size]
  ([(data.data.data.size, data.data.rows),
    (data.data.data.size, data.data.cols),
    (data.data_error_upper.data.size, data.data_error_upper.rows),
    (data.data_error_upper.data.size, data.data_error_upper.cols),
    (data.data_error_lower.data.size, data.data_error_lower.rows),
    (data.data_error_lower.data.size, data.data_error_lower.cols)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates1)

def «core_profiles/covariance».storageValidBool (data : «core_profiles/covariance») : Bool :=
  data.data.storageValid &&
  data.data_error_upper.storageValid &&
  data.data_error_lower.storageValid

def «core_profiles/covariance».coordinatesValid (data : «core_profiles/covariance») : Prop :=
  «core_profiles/covariance».coordinatesValidBool data = true

instance (data : «core_profiles/covariance») : Decidable («core_profiles/covariance».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/covariance».coordinatesValidBool data = true))

def «core_profiles/covariance».storageValid (data : «core_profiles/covariance») : Prop :=
  «core_profiles/covariance».storageValidBool data = true

instance (data : «core_profiles/covariance») : Decidable («core_profiles/covariance».storageValid data) :=
  inferInstanceAs (Decidable («core_profiles/covariance».storageValidBool data = true))

def «core_profiles/covariance».isValid (data : «core_profiles/covariance») : Prop :=
  «core_profiles/covariance».coordinatesValid data ∧ «core_profiles/covariance».storageValid data

instance (data : «core_profiles/covariance») : Decidable («core_profiles/covariance».isValid data) := by
  unfold «core_profiles/covariance».isValid
  infer_instance

def «core_profiles/statistics/quantity_2d/statistics_type».coordinatesValidBool (data : «core_profiles/statistics/quantity_2d/statistics_type») : Bool :=
  let coordinates1 := [data.value.size]
  let coordinates2 := [data.value_error_upper.size]
  (data.value_error_upper.size == 0 || coordinateSizesMatch data.value_error_upper.size coordinates1) &&
  (data.value_error_lower.size == 0 || coordinateSizesMatch data.value_error_lower.size coordinates2)

def «core_profiles/statistics/quantity_2d/statistics_type».coordinatesValid (data : «core_profiles/statistics/quantity_2d/statistics_type») : Prop :=
  «core_profiles/statistics/quantity_2d/statistics_type».coordinatesValidBool data = true

instance (data : «core_profiles/statistics/quantity_2d/statistics_type») : Decidable («core_profiles/statistics/quantity_2d/statistics_type».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/statistics/quantity_2d/statistics_type».coordinatesValidBool data = true))

def «core_profiles/statistics/quantity_2d/statistics_type».isValid (data : «core_profiles/statistics/quantity_2d/statistics_type») : Prop :=
  «core_profiles/statistics/quantity_2d/statistics_type».coordinatesValid data

instance (data : «core_profiles/statistics/quantity_2d/statistics_type») : Decidable («core_profiles/statistics/quantity_2d/statistics_type».isValid data) := by
  unfold «core_profiles/statistics/quantity_2d/statistics_type».isValid
  infer_instance

def «core_profiles/statistics/quantity_2d/distribution».coordinatesValidBool (data : «core_profiles/statistics/quantity_2d/distribution») : Bool :=
  -- Matrix pairs contain storage length and the dimension being checked.
  let coordinates1 := [data.bins.rows]
  let coordinates2 := [data.bins.cols]
  let coordinates3 := [data.bins_error_upper.rows]
  let coordinates4 := [data.bins_error_upper.cols]
  let coordinates5 := [data.probability.cols]
  let coordinates6 := [data.probability_error_upper.cols]
  ([(data.bins_error_upper.data.size, data.bins_error_upper.rows),
    (data.probability.data.size, data.probability.rows),
    (data.probability_error_upper.data.size, data.probability_error_upper.rows),
    (data.probability_error_lower.data.size, data.probability_error_lower.rows)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates1) &&
  ([(data.bins_error_upper.data.size, data.bins_error_upper.cols)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates2) &&
  ([(data.bins_error_lower.data.size, data.bins_error_lower.rows)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates3) &&
  ([(data.bins_error_lower.data.size, data.bins_error_lower.cols)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates4) &&
  ([(data.probability_error_upper.data.size, data.probability_error_upper.cols)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates5) &&
  ([(data.probability_error_lower.data.size, data.probability_error_lower.cols)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates6)

def «core_profiles/statistics/quantity_2d/distribution».storageValidBool (data : «core_profiles/statistics/quantity_2d/distribution») : Bool :=
  data.bins.storageValid &&
  data.bins_error_upper.storageValid &&
  data.bins_error_lower.storageValid &&
  data.probability.storageValid &&
  data.probability_error_upper.storageValid &&
  data.probability_error_lower.storageValid

def «core_profiles/statistics/quantity_2d/distribution».coordinatesValid (data : «core_profiles/statistics/quantity_2d/distribution») : Prop :=
  «core_profiles/statistics/quantity_2d/distribution».coordinatesValidBool data = true

instance (data : «core_profiles/statistics/quantity_2d/distribution») : Decidable («core_profiles/statistics/quantity_2d/distribution».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/statistics/quantity_2d/distribution».coordinatesValidBool data = true))

def «core_profiles/statistics/quantity_2d/distribution».storageValid (data : «core_profiles/statistics/quantity_2d/distribution») : Prop :=
  «core_profiles/statistics/quantity_2d/distribution».storageValidBool data = true

instance (data : «core_profiles/statistics/quantity_2d/distribution») : Decidable («core_profiles/statistics/quantity_2d/distribution».storageValid data) :=
  inferInstanceAs (Decidable («core_profiles/statistics/quantity_2d/distribution».storageValidBool data = true))

def «core_profiles/statistics/quantity_2d/distribution».isValid (data : «core_profiles/statistics/quantity_2d/distribution») : Prop :=
  «core_profiles/statistics/quantity_2d/distribution».coordinatesValid data ∧ «core_profiles/statistics/quantity_2d/distribution».storageValid data

instance (data : «core_profiles/statistics/quantity_2d/distribution») : Decidable («core_profiles/statistics/quantity_2d/distribution».isValid data) := by
  unfold «core_profiles/statistics/quantity_2d/distribution».isValid
  infer_instance

def «core_profiles/statistics/quantity_2d».coordinatesValidBool (data : «core_profiles/statistics/quantity_2d») : Bool :=
  data.statistics_type.toList.all «core_profiles/statistics/quantity_2d/statistics_type».coordinatesValidBool &&
  «core_profiles/statistics/quantity_2d/distribution».coordinatesValidBool data.distribution

def «core_profiles/statistics/quantity_2d».storageValidBool (data : «core_profiles/statistics/quantity_2d») : Bool :=
  «core_profiles/statistics/quantity_2d/distribution».storageValidBool data.distribution

def «core_profiles/statistics/quantity_2d».coordinatesValid (data : «core_profiles/statistics/quantity_2d») : Prop :=
  «core_profiles/statistics/quantity_2d».coordinatesValidBool data = true

instance (data : «core_profiles/statistics/quantity_2d») : Decidable («core_profiles/statistics/quantity_2d».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/statistics/quantity_2d».coordinatesValidBool data = true))

def «core_profiles/statistics/quantity_2d».storageValid (data : «core_profiles/statistics/quantity_2d») : Prop :=
  «core_profiles/statistics/quantity_2d».storageValidBool data = true

instance (data : «core_profiles/statistics/quantity_2d») : Decidable («core_profiles/statistics/quantity_2d».storageValid data) :=
  inferInstanceAs (Decidable («core_profiles/statistics/quantity_2d».storageValidBool data = true))

def «core_profiles/statistics/quantity_2d».isValid (data : «core_profiles/statistics/quantity_2d») : Prop :=
  «core_profiles/statistics/quantity_2d».coordinatesValid data ∧ «core_profiles/statistics/quantity_2d».storageValid data

instance (data : «core_profiles/statistics/quantity_2d») : Decidable («core_profiles/statistics/quantity_2d».isValid data) := by
  unfold «core_profiles/statistics/quantity_2d».isValid
  infer_instance

def «core_profiles/statistics/uq_input_2d/distribution».coordinatesValidBool (data : «core_profiles/statistics/uq_input_2d/distribution») : Bool :=
  -- Matrix pairs contain storage length and the dimension being checked.
  let coordinates1 := [data.bins.rows]
  let coordinates2 := [data.bins.cols]
  let coordinates3 := [data.bins_error_upper.rows]
  let coordinates4 := [data.bins_error_upper.cols]
  let coordinates5 := [data.probability.cols]
  let coordinates6 := [data.probability_error_upper.cols]
  ([(data.bins_error_upper.data.size, data.bins_error_upper.rows),
    (data.probability.data.size, data.probability.rows),
    (data.probability_error_upper.data.size, data.probability_error_upper.rows),
    (data.probability_error_lower.data.size, data.probability_error_lower.rows)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates1) &&
  ([(data.bins_error_upper.data.size, data.bins_error_upper.cols)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates2) &&
  ([(data.bins_error_lower.data.size, data.bins_error_lower.rows)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates3) &&
  ([(data.bins_error_lower.data.size, data.bins_error_lower.cols)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates4) &&
  ([(data.probability_error_upper.data.size, data.probability_error_upper.cols)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates5) &&
  ([(data.probability_error_lower.data.size, data.probability_error_lower.cols)].all fun (stored, size) =>
    stored == 0 || coordinateSizesMatch size coordinates6)

def «core_profiles/statistics/uq_input_2d/distribution».storageValidBool (data : «core_profiles/statistics/uq_input_2d/distribution») : Bool :=
  data.bins.storageValid &&
  data.bins_error_upper.storageValid &&
  data.bins_error_lower.storageValid &&
  data.probability.storageValid &&
  data.probability_error_upper.storageValid &&
  data.probability_error_lower.storageValid

def «core_profiles/statistics/uq_input_2d/distribution».coordinatesValid (data : «core_profiles/statistics/uq_input_2d/distribution») : Prop :=
  «core_profiles/statistics/uq_input_2d/distribution».coordinatesValidBool data = true

instance (data : «core_profiles/statistics/uq_input_2d/distribution») : Decidable («core_profiles/statistics/uq_input_2d/distribution».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/statistics/uq_input_2d/distribution».coordinatesValidBool data = true))

def «core_profiles/statistics/uq_input_2d/distribution».storageValid (data : «core_profiles/statistics/uq_input_2d/distribution») : Prop :=
  «core_profiles/statistics/uq_input_2d/distribution».storageValidBool data = true

instance (data : «core_profiles/statistics/uq_input_2d/distribution») : Decidable («core_profiles/statistics/uq_input_2d/distribution».storageValid data) :=
  inferInstanceAs (Decidable («core_profiles/statistics/uq_input_2d/distribution».storageValidBool data = true))

def «core_profiles/statistics/uq_input_2d/distribution».isValid (data : «core_profiles/statistics/uq_input_2d/distribution») : Prop :=
  «core_profiles/statistics/uq_input_2d/distribution».coordinatesValid data ∧ «core_profiles/statistics/uq_input_2d/distribution».storageValid data

instance (data : «core_profiles/statistics/uq_input_2d/distribution») : Decidable («core_profiles/statistics/uq_input_2d/distribution».isValid data) := by
  unfold «core_profiles/statistics/uq_input_2d/distribution».isValid
  infer_instance

def «core_profiles/statistics/uq_input_2d».coordinatesValidBool (data : «core_profiles/statistics/uq_input_2d») : Bool :=
  «core_profiles/statistics/uq_input_2d/distribution».coordinatesValidBool data.distribution

def «core_profiles/statistics/uq_input_2d».storageValidBool (data : «core_profiles/statistics/uq_input_2d») : Bool :=
  «core_profiles/statistics/uq_input_2d/distribution».storageValidBool data.distribution

def «core_profiles/statistics/uq_input_2d».coordinatesValid (data : «core_profiles/statistics/uq_input_2d») : Prop :=
  «core_profiles/statistics/uq_input_2d».coordinatesValidBool data = true

instance (data : «core_profiles/statistics/uq_input_2d») : Decidable («core_profiles/statistics/uq_input_2d».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/statistics/uq_input_2d».coordinatesValidBool data = true))

def «core_profiles/statistics/uq_input_2d».storageValid (data : «core_profiles/statistics/uq_input_2d») : Prop :=
  «core_profiles/statistics/uq_input_2d».storageValidBool data = true

instance (data : «core_profiles/statistics/uq_input_2d») : Decidable («core_profiles/statistics/uq_input_2d».storageValid data) :=
  inferInstanceAs (Decidable («core_profiles/statistics/uq_input_2d».storageValidBool data = true))

def «core_profiles/statistics/uq_input_2d».isValid (data : «core_profiles/statistics/uq_input_2d») : Prop :=
  «core_profiles/statistics/uq_input_2d».coordinatesValid data ∧ «core_profiles/statistics/uq_input_2d».storageValid data

instance (data : «core_profiles/statistics/uq_input_2d») : Decidable («core_profiles/statistics/uq_input_2d».isValid data) := by
  unfold «core_profiles/statistics/uq_input_2d».isValid
  infer_instance

def «core_profiles/statistics».coordinatesValidBool (data : «core_profiles/statistics») : Bool :=
  data.quantity_2d.toList.all «core_profiles/statistics/quantity_2d».coordinatesValidBool &&
  data.uq_input_2d.toList.all «core_profiles/statistics/uq_input_2d».coordinatesValidBool

def «core_profiles/statistics».storageValidBool (data : «core_profiles/statistics») : Bool :=
  data.quantity_2d.toList.all «core_profiles/statistics/quantity_2d».storageValidBool &&
  data.uq_input_2d.toList.all «core_profiles/statistics/uq_input_2d».storageValidBool

def «core_profiles/statistics».coordinatesValid (data : «core_profiles/statistics») : Prop :=
  «core_profiles/statistics».coordinatesValidBool data = true

instance (data : «core_profiles/statistics») : Decidable («core_profiles/statistics».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles/statistics».coordinatesValidBool data = true))

def «core_profiles/statistics».storageValid (data : «core_profiles/statistics») : Prop :=
  «core_profiles/statistics».storageValidBool data = true

instance (data : «core_profiles/statistics») : Decidable («core_profiles/statistics».storageValid data) :=
  inferInstanceAs (Decidable («core_profiles/statistics».storageValidBool data = true))

def «core_profiles/statistics».isValid (data : «core_profiles/statistics») : Prop :=
  «core_profiles/statistics».coordinatesValid data ∧ «core_profiles/statistics».storageValid data

instance (data : «core_profiles/statistics») : Decidable («core_profiles/statistics».isValid data) := by
  unfold «core_profiles/statistics».isValid
  infer_instance

def «core_profiles».coordinatesValidBool (data : «core_profiles») : Bool :=
  let coordinates1 := [data.time.size]
  (data.profiles_1d.size == 0 || ((data.ids_properties.homogeneous_time == some 1 && data.profiles_1d.size == data.time.size) || (data.ids_properties.homogeneous_time == some 0 && data.profiles_1d.toList.all (fun item => item.time.isSome)))) &&
  (data.profiles_2d.size == 0 || ((data.ids_properties.homogeneous_time == some 1 && data.profiles_2d.size == data.time.size) || (data.ids_properties.homogeneous_time == some 0 && data.profiles_2d.toList.all (fun item => item.time.isSome)))) &&
  (data.statistics.size == 0 || ((data.ids_properties.homogeneous_time == some 1 && data.statistics.size == data.time.size) || (data.ids_properties.homogeneous_time == some 0 && data.statistics.toList.all (fun item => item.time.isSome)))) &&
  ([data.global_quantities.ip.size,
    data.global_quantities.ip_error_upper.size,
    data.global_quantities.ip_error_lower.size,
    data.global_quantities.current_non_inductive.size,
    data.global_quantities.current_non_inductive_error_upper.size,
    data.global_quantities.current_non_inductive_error_lower.size,
    data.global_quantities.current_bootstrap.size,
    data.global_quantities.current_bootstrap_error_upper.size,
    data.global_quantities.current_bootstrap_error_lower.size,
    data.global_quantities.v_loop.size,
    data.global_quantities.v_loop_error_upper.size,
    data.global_quantities.v_loop_error_lower.size,
    data.global_quantities.li_3.size,
    data.global_quantities.li_3_error_upper.size,
    data.global_quantities.li_3_error_lower.size,
    data.global_quantities.beta_tor.size,
    data.global_quantities.beta_tor_error_upper.size,
    data.global_quantities.beta_tor_error_lower.size,
    data.global_quantities.beta_tor_norm.size,
    data.global_quantities.beta_tor_norm_error_upper.size,
    data.global_quantities.beta_tor_norm_error_lower.size,
    data.global_quantities.beta_pol.size,
    data.global_quantities.beta_pol_error_upper.size,
    data.global_quantities.beta_pol_error_lower.size,
    data.global_quantities.energy_diamagnetic.size,
    data.global_quantities.energy_diamagnetic_error_upper.size,
    data.global_quantities.energy_diamagnetic_error_lower.size,
    data.global_quantities.z_eff_resistive.size,
    data.global_quantities.z_eff_resistive_error_upper.size,
    data.global_quantities.z_eff_resistive_error_lower.size,
    data.global_quantities.t_e_peaking.size,
    data.global_quantities.t_e_peaking_error_upper.size,
    data.global_quantities.t_e_peaking_error_lower.size,
    data.global_quantities.t_i_average_peaking.size,
    data.global_quantities.t_i_average_peaking_error_upper.size,
    data.global_quantities.t_i_average_peaking_error_lower.size,
    data.global_quantities.resistive_psi_losses.size,
    data.global_quantities.resistive_psi_losses_error_upper.size,
    data.global_quantities.resistive_psi_losses_error_lower.size,
    data.global_quantities.ejima.size,
    data.global_quantities.ejima_error_upper.size,
    data.global_quantities.ejima_error_lower.size,
    data.global_quantities.t_e_volume_average.size,
    data.global_quantities.t_e_volume_average_error_upper.size,
    data.global_quantities.t_e_volume_average_error_lower.size,
    data.global_quantities.n_e_volume_average.size,
    data.global_quantities.n_e_volume_average_error_upper.size,
    data.global_quantities.n_e_volume_average_error_lower.size,
    data.vacuum_toroidal_field.b0.size,
    data.vacuum_toroidal_field.b0_error_upper.size,
    data.vacuum_toroidal_field.b0_error_lower.size,
    data.code.output_flag.size].all fun size =>
    size == 0 || coordinateSizesMatch size coordinates1) &&
  (data.global_quantities.ion.toList.all fun item1 =>
    ([item1.t_i_volume_average.size,
    item1.t_i_volume_average_error_upper.size,
    item1.t_i_volume_average_error_lower.size,
    item1.n_i_volume_average.size,
    item1.n_i_volume_average_error_upper.size,
    item1.n_i_volume_average_error_lower.size].all fun size =>
    size == 0 || coordinateSizesMatch size coordinates1)) &&
  data.profiles_1d.toList.all «core_profiles/profiles_1d».coordinatesValidBool &&
  data.profiles_2d.toList.all «core_profiles/profiles_2d».coordinatesValidBool &&
  «core_profiles/covariance».coordinatesValidBool data.covariance &&
  data.statistics.toList.all «core_profiles/statistics».coordinatesValidBool

def «core_profiles».storageValidBool (data : «core_profiles») : Bool :=
  data.profiles_2d.toList.all «core_profiles/profiles_2d».storageValidBool &&
  «core_profiles/covariance».storageValidBool data.covariance &&
  data.statistics.toList.all «core_profiles/statistics».storageValidBool

def «core_profiles».coordinatesValid (data : «core_profiles») : Prop :=
  «core_profiles».coordinatesValidBool data = true

instance (data : «core_profiles») : Decidable («core_profiles».coordinatesValid data) :=
  inferInstanceAs (Decidable («core_profiles».coordinatesValidBool data = true))

def «core_profiles».storageValid (data : «core_profiles») : Prop :=
  «core_profiles».storageValidBool data = true

instance (data : «core_profiles») : Decidable («core_profiles».storageValid data) :=
  inferInstanceAs (Decidable («core_profiles».storageValidBool data = true))

def «core_profiles».isValid (data : «core_profiles») : Prop :=
  «core_profiles».coordinatesValid data ∧ «core_profiles».storageValid data

instance (data : «core_profiles») : Decidable («core_profiles».isValid data) := by
  unfold «core_profiles».isValid
  infer_instance

end IMAS
