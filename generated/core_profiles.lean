-- Generated from IMAS DD core_profiles. Regenerate rather than editing.
-- Each record is named by its DD path; «...» makes the path one Lean name.
-- Option means a scalar may be missing; Array and Matrix represent arrays.
-- Defaults make it possible to construct a partial IDS without filling every field.
-- The source XML's unit spellings are retained as tags; «...» is Lean quoting.
import Std

namespace IMAS

inductive Unit where
  | «1»
  | A
  | «A.m^-2»
  | J
  | Pa
  | T
  | V
  | «V.m^-1»
  | Wb
  | e
  | eV
  | «kg.m^-1.s^-1»
  | m
  | «m.s^-1»
  | «m^-3»
  | «m^2»
  | «m^3»
  | mixed
  | «ohm^-1.m^-1»
  | «rad.s^-1»
  | s
  | «s^-1»
  | u
  deriving DecidableEq

-- Quantity pairs a value with its DD unit at the type level. The unit tag
-- prevents, for example, treating a value in eV as one in Wb without conversion.
-- α is the value type; Float is used when no other type is given.
structure Quantity (unit : Unit) (α : Type := Float) where
  value : α

-- Inhabited supplies a default value when the underlying type has one.
instance [Inhabited α] : Inhabited (Quantity unit α) := ⟨⟨default⟩⟩

-- Rectangular, row-major storage for the DD's two-dimensional arrays.
structure Matrix (α : Type) where
  rows : Nat
  cols : Nat
  data : Array α
  size_eq : data.size = rows * cols  -- proof that the flat storage fits the shape

instance : Inhabited (Matrix α) := ⟨⟨0, 0, #[], rfl⟩⟩

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
  rho_tor_norm : Array (Quantity .«1») := default
  rho_tor_norm_error_upper : Array (Quantity .«1») := default
  rho_tor_norm_error_lower : Array (Quantity .«1») := default
  rho_tor : Array (Quantity .m) := default
  rho_tor_error_upper : Array (Quantity .m) := default
  rho_tor_error_lower : Array (Quantity .m) := default
  rho_pol_norm : Array (Quantity .«1») := default
  rho_pol_norm_error_upper : Array (Quantity .«1») := default
  rho_pol_norm_error_lower : Array (Quantity .«1») := default
  psi : Array (Quantity .Wb) := default
  psi_error_upper : Array (Quantity .Wb) := default
  psi_error_lower : Array (Quantity .Wb) := default
  volume : Array (Quantity .«m^3») := default
  volume_error_upper : Array (Quantity .«m^3») := default
  volume_error_lower : Array (Quantity .«m^3») := default
  area : Array (Quantity .«m^2») := default
  area_error_upper : Array (Quantity .«m^2») := default
  area_error_lower : Array (Quantity .«m^2») := default
  surface : Array (Quantity .«m^2») := default
  surface_error_upper : Array (Quantity .«m^2») := default
  surface_error_lower : Array (Quantity .«m^2») := default
  psi_magnetic_axis : Option (Quantity .Wb) := default
  psi_magnetic_axis_error_upper : Option (Quantity .Wb) := default
  psi_magnetic_axis_error_lower : Option (Quantity .Wb) := default
  psi_boundary : Option (Quantity .Wb) := default
  psi_boundary_error_upper : Option (Quantity .Wb) := default
  psi_boundary_error_lower : Option (Quantity .Wb) := default
  deriving Inhabited

structure «core_profiles/profiles_1d/electrons/temperature_fit/time_measurement_slice_method» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/electrons/temperature_fit» where
  measured : Array (Quantity .mixed) := default
  measured_error_upper : Array (Quantity .mixed) := default
  measured_error_lower : Array (Quantity .mixed) := default
  source : Array String := default
  time_measurement : Array (Quantity .s) := default
  time_measurement_error_upper : Array (Quantity .s) := default
  time_measurement_error_lower : Array (Quantity .s) := default
  time_measurement_slice_method : IMAS.«core_profiles/profiles_1d/electrons/temperature_fit/time_measurement_slice_method» := default
  time_measurement_width : Array (Quantity .s) := default
  time_measurement_width_error_upper : Array (Quantity .s) := default
  time_measurement_width_error_lower : Array (Quantity .s) := default
  «local» : Array Int32 := default
  rho_tor_norm : Array (Quantity .«1») := default
  rho_tor_norm_error_upper : Array (Quantity .«1») := default
  rho_tor_norm_error_lower : Array (Quantity .«1») := default
  weight : Array (Quantity .«1») := default
  weight_error_upper : Array (Quantity .«1») := default
  weight_error_lower : Array (Quantity .«1») := default
  reconstructed : Array (Quantity .mixed) := default
  reconstructed_error_upper : Array (Quantity .mixed) := default
  reconstructed_error_lower : Array (Quantity .mixed) := default
  chi_squared : Array (Quantity .«1») := default
  chi_squared_error_upper : Array (Quantity .«1») := default
  chi_squared_error_lower : Array (Quantity .«1») := default
  parameters : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/electrons/density_fit/time_measurement_slice_method» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/electrons/density_fit» where
  measured : Array (Quantity .mixed) := default
  measured_error_upper : Array (Quantity .mixed) := default
  measured_error_lower : Array (Quantity .mixed) := default
  source : Array String := default
  time_measurement : Array (Quantity .s) := default
  time_measurement_error_upper : Array (Quantity .s) := default
  time_measurement_error_lower : Array (Quantity .s) := default
  time_measurement_slice_method : IMAS.«core_profiles/profiles_1d/electrons/density_fit/time_measurement_slice_method» := default
  time_measurement_width : Array (Quantity .s) := default
  time_measurement_width_error_upper : Array (Quantity .s) := default
  time_measurement_width_error_lower : Array (Quantity .s) := default
  «local» : Array Int32 := default
  rho_tor_norm : Array (Quantity .«1») := default
  rho_tor_norm_error_upper : Array (Quantity .«1») := default
  rho_tor_norm_error_lower : Array (Quantity .«1») := default
  weight : Array (Quantity .«1») := default
  weight_error_upper : Array (Quantity .«1») := default
  weight_error_lower : Array (Quantity .«1») := default
  reconstructed : Array (Quantity .mixed) := default
  reconstructed_error_upper : Array (Quantity .mixed) := default
  reconstructed_error_lower : Array (Quantity .mixed) := default
  chi_squared : Array (Quantity .«1») := default
  chi_squared_error_upper : Array (Quantity .«1») := default
  chi_squared_error_lower : Array (Quantity .«1») := default
  parameters : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/electrons» where
  temperature : Array (Quantity .eV) := default
  temperature_error_upper : Array (Quantity .eV) := default
  temperature_error_lower : Array (Quantity .eV) := default
  temperature_validity : Option Int32 := default
  temperature_fit : Quantity .eV IMAS.«core_profiles/profiles_1d/electrons/temperature_fit» := default
  density : Array (Quantity .«m^-3») := default
  density_error_upper : Array (Quantity .«m^-3») := default
  density_error_lower : Array (Quantity .«m^-3») := default
  density_validity : Option Int32 := default
  density_fit : Quantity .«m^-3» IMAS.«core_profiles/profiles_1d/electrons/density_fit» := default
  density_thermal : Array (Quantity .«m^-3») := default
  density_thermal_error_upper : Array (Quantity .«m^-3») := default
  density_thermal_error_lower : Array (Quantity .«m^-3») := default
  density_fast : Array (Quantity .«m^-3») := default
  density_fast_error_upper : Array (Quantity .«m^-3») := default
  density_fast_error_lower : Array (Quantity .«m^-3») := default
  pressure : Array (Quantity .Pa) := default
  pressure_error_upper : Array (Quantity .Pa) := default
  pressure_error_lower : Array (Quantity .Pa) := default
  pressure_thermal : Array (Quantity .Pa) := default
  pressure_thermal_error_upper : Array (Quantity .Pa) := default
  pressure_thermal_error_lower : Array (Quantity .Pa) := default
  pressure_fast_perpendicular : Array (Quantity .Pa) := default
  pressure_fast_perpendicular_error_upper : Array (Quantity .Pa) := default
  pressure_fast_perpendicular_error_lower : Array (Quantity .Pa) := default
  pressure_fast_parallel : Array (Quantity .Pa) := default
  pressure_fast_parallel_error_upper : Array (Quantity .Pa) := default
  pressure_fast_parallel_error_lower : Array (Quantity .Pa) := default
  collisionality_norm : Array (Quantity .«1») := default
  collisionality_norm_error_upper : Array (Quantity .«1») := default
  collisionality_norm_error_lower : Array (Quantity .«1») := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/element» where
  a : Option (Quantity .u) := default
  a_error_upper : Option (Quantity .u) := default
  a_error_lower : Option (Quantity .u) := default
  z_n : Option (Quantity .e Int32) := default
  atoms_n : Option Int32 := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/temperature_fit/time_measurement_slice_method» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/temperature_fit» where
  measured : Array (Quantity .mixed) := default
  measured_error_upper : Array (Quantity .mixed) := default
  measured_error_lower : Array (Quantity .mixed) := default
  source : Array String := default
  time_measurement : Array (Quantity .s) := default
  time_measurement_error_upper : Array (Quantity .s) := default
  time_measurement_error_lower : Array (Quantity .s) := default
  time_measurement_slice_method : IMAS.«core_profiles/profiles_1d/ion/temperature_fit/time_measurement_slice_method» := default
  time_measurement_width : Array (Quantity .s) := default
  time_measurement_width_error_upper : Array (Quantity .s) := default
  time_measurement_width_error_lower : Array (Quantity .s) := default
  «local» : Array Int32 := default
  rho_tor_norm : Array (Quantity .«1») := default
  rho_tor_norm_error_upper : Array (Quantity .«1») := default
  rho_tor_norm_error_lower : Array (Quantity .«1») := default
  weight : Array (Quantity .«1») := default
  weight_error_upper : Array (Quantity .«1») := default
  weight_error_lower : Array (Quantity .«1») := default
  reconstructed : Array (Quantity .mixed) := default
  reconstructed_error_upper : Array (Quantity .mixed) := default
  reconstructed_error_lower : Array (Quantity .mixed) := default
  chi_squared : Array (Quantity .«1») := default
  chi_squared_error_upper : Array (Quantity .«1») := default
  chi_squared_error_lower : Array (Quantity .«1») := default
  parameters : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/density_fit/time_measurement_slice_method» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/density_fit» where
  measured : Array (Quantity .mixed) := default
  measured_error_upper : Array (Quantity .mixed) := default
  measured_error_lower : Array (Quantity .mixed) := default
  source : Array String := default
  time_measurement : Array (Quantity .s) := default
  time_measurement_error_upper : Array (Quantity .s) := default
  time_measurement_error_lower : Array (Quantity .s) := default
  time_measurement_slice_method : IMAS.«core_profiles/profiles_1d/ion/density_fit/time_measurement_slice_method» := default
  time_measurement_width : Array (Quantity .s) := default
  time_measurement_width_error_upper : Array (Quantity .s) := default
  time_measurement_width_error_lower : Array (Quantity .s) := default
  «local» : Array Int32 := default
  rho_tor_norm : Array (Quantity .«1») := default
  rho_tor_norm_error_upper : Array (Quantity .«1») := default
  rho_tor_norm_error_lower : Array (Quantity .«1») := default
  weight : Array (Quantity .«1») := default
  weight_error_upper : Array (Quantity .«1») := default
  weight_error_lower : Array (Quantity .«1») := default
  reconstructed : Array (Quantity .mixed) := default
  reconstructed_error_upper : Array (Quantity .mixed) := default
  reconstructed_error_lower : Array (Quantity .mixed) := default
  chi_squared : Array (Quantity .«1») := default
  chi_squared_error_upper : Array (Quantity .«1») := default
  chi_squared_error_lower : Array (Quantity .«1») := default
  parameters : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/velocity» where
  radial : Array (Quantity .«m.s^-1») := default
  radial_error_upper : Array (Quantity .«m.s^-1») := default
  radial_error_lower : Array (Quantity .«m.s^-1») := default
  diamagnetic : Array (Quantity .«m.s^-1») := default
  diamagnetic_error_upper : Array (Quantity .«m.s^-1») := default
  diamagnetic_error_lower : Array (Quantity .«m.s^-1») := default
  parallel : Array (Quantity .«m.s^-1») := default
  parallel_error_upper : Array (Quantity .«m.s^-1») := default
  parallel_error_lower : Array (Quantity .«m.s^-1») := default
  poloidal : Array (Quantity .«m.s^-1») := default
  poloidal_error_upper : Array (Quantity .«m.s^-1») := default
  poloidal_error_lower : Array (Quantity .«m.s^-1») := default
  toroidal : Array (Quantity .«m.s^-1») := default
  toroidal_error_upper : Array (Quantity .«m.s^-1») := default
  toroidal_error_lower : Array (Quantity .«m.s^-1») := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/state/velocity» where
  radial : Array (Quantity .«m.s^-1») := default
  radial_error_upper : Array (Quantity .«m.s^-1») := default
  radial_error_lower : Array (Quantity .«m.s^-1») := default
  diamagnetic : Array (Quantity .«m.s^-1») := default
  diamagnetic_error_upper : Array (Quantity .«m.s^-1») := default
  diamagnetic_error_lower : Array (Quantity .«m.s^-1») := default
  parallel : Array (Quantity .«m.s^-1») := default
  parallel_error_upper : Array (Quantity .«m.s^-1») := default
  parallel_error_lower : Array (Quantity .«m.s^-1») := default
  poloidal : Array (Quantity .«m.s^-1») := default
  poloidal_error_upper : Array (Quantity .«m.s^-1») := default
  poloidal_error_lower : Array (Quantity .«m.s^-1») := default
  toroidal : Array (Quantity .«m.s^-1») := default
  toroidal_error_upper : Array (Quantity .«m.s^-1») := default
  toroidal_error_lower : Array (Quantity .«m.s^-1») := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/state/density_fit/time_measurement_slice_method» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/state/density_fit» where
  measured : Array (Quantity .mixed) := default
  measured_error_upper : Array (Quantity .mixed) := default
  measured_error_lower : Array (Quantity .mixed) := default
  source : Array String := default
  time_measurement : Array (Quantity .s) := default
  time_measurement_error_upper : Array (Quantity .s) := default
  time_measurement_error_lower : Array (Quantity .s) := default
  time_measurement_slice_method : IMAS.«core_profiles/profiles_1d/ion/state/density_fit/time_measurement_slice_method» := default
  time_measurement_width : Array (Quantity .s) := default
  time_measurement_width_error_upper : Array (Quantity .s) := default
  time_measurement_width_error_lower : Array (Quantity .s) := default
  «local» : Array Int32 := default
  rho_tor_norm : Array (Quantity .«1») := default
  rho_tor_norm_error_upper : Array (Quantity .«1») := default
  rho_tor_norm_error_lower : Array (Quantity .«1») := default
  weight : Array (Quantity .«1») := default
  weight_error_upper : Array (Quantity .«1») := default
  weight_error_lower : Array (Quantity .«1») := default
  reconstructed : Array (Quantity .mixed) := default
  reconstructed_error_upper : Array (Quantity .mixed) := default
  reconstructed_error_lower : Array (Quantity .mixed) := default
  chi_squared : Array (Quantity .«1») := default
  chi_squared_error_upper : Array (Quantity .«1») := default
  chi_squared_error_lower : Array (Quantity .«1») := default
  parameters : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion/state» where
  z_min : Option (Quantity .e) := default
  z_min_error_upper : Option (Quantity .e) := default
  z_min_error_lower : Option (Quantity .e) := default
  z_max : Option (Quantity .e) := default
  z_max_error_upper : Option (Quantity .e) := default
  z_max_error_lower : Option (Quantity .e) := default
  z_average : Option (Quantity .e) := default
  z_average_error_upper : Option (Quantity .e) := default
  z_average_error_lower : Option (Quantity .e) := default
  z_square_average : Option (Quantity .e) := default
  z_square_average_error_upper : Option (Quantity .e) := default
  z_square_average_error_lower : Option (Quantity .e) := default
  z_average_1d : Array (Quantity .«1») := default
  z_average_1d_error_upper : Array (Quantity .«1») := default
  z_average_1d_error_lower : Array (Quantity .«1») := default
  z_average_square_1d : Array (Quantity .«1») := default
  z_average_square_1d_error_upper : Array (Quantity .«1») := default
  z_average_square_1d_error_lower : Array (Quantity .«1») := default
  ionization_potential : Option (Quantity .eV) := default
  ionization_potential_error_upper : Option (Quantity .eV) := default
  ionization_potential_error_lower : Option (Quantity .eV) := default
  name : Option String := default
  electron_configuration : Option String := default
  vibrational_level : Option (Quantity .e) := default
  vibrational_level_error_upper : Option (Quantity .e) := default
  vibrational_level_error_lower : Option (Quantity .e) := default
  vibrational_mode : Option String := default
  rotation_frequency_tor : Array (Quantity .«rad.s^-1») := default
  rotation_frequency_tor_error_upper : Array (Quantity .«rad.s^-1») := default
  rotation_frequency_tor_error_lower : Array (Quantity .«rad.s^-1») := default
  velocity : Quantity .«m.s^-1» IMAS.«core_profiles/profiles_1d/ion/state/velocity» := default
  temperature : Array (Quantity .eV) := default
  temperature_error_upper : Array (Quantity .eV) := default
  temperature_error_lower : Array (Quantity .eV) := default
  density : Array (Quantity .«m^-3») := default
  density_error_upper : Array (Quantity .«m^-3») := default
  density_error_lower : Array (Quantity .«m^-3») := default
  density_fit : Quantity .«m^-3» IMAS.«core_profiles/profiles_1d/ion/state/density_fit» := default
  density_thermal : Array (Quantity .«m^-3») := default
  density_thermal_error_upper : Array (Quantity .«m^-3») := default
  density_thermal_error_lower : Array (Quantity .«m^-3») := default
  density_fast : Array (Quantity .«m^-3») := default
  density_fast_error_upper : Array (Quantity .«m^-3») := default
  density_fast_error_lower : Array (Quantity .«m^-3») := default
  pressure : Array (Quantity .Pa) := default
  pressure_error_upper : Array (Quantity .Pa) := default
  pressure_error_lower : Array (Quantity .Pa) := default
  pressure_thermal : Array (Quantity .Pa) := default
  pressure_thermal_error_upper : Array (Quantity .Pa) := default
  pressure_thermal_error_lower : Array (Quantity .Pa) := default
  pressure_fast_perpendicular : Array (Quantity .Pa) := default
  pressure_fast_perpendicular_error_upper : Array (Quantity .Pa) := default
  pressure_fast_perpendicular_error_lower : Array (Quantity .Pa) := default
  pressure_fast_parallel : Array (Quantity .Pa) := default
  pressure_fast_parallel_error_upper : Array (Quantity .Pa) := default
  pressure_fast_parallel_error_lower : Array (Quantity .Pa) := default
  deriving Inhabited

structure «core_profiles/profiles_1d/ion» where
  element : Array IMAS.«core_profiles/profiles_1d/ion/element» := default
  z_ion : Option (Quantity .e) := default
  z_ion_error_upper : Option (Quantity .e) := default
  z_ion_error_lower : Option (Quantity .e) := default
  name : Option String := default
  neutral_index : Option Int32 := default
  z_ion_1d : Array (Quantity .«1») := default
  z_ion_1d_error_upper : Array (Quantity .«1») := default
  z_ion_1d_error_lower : Array (Quantity .«1») := default
  z_ion_square_1d : Array (Quantity .«1») := default
  z_ion_square_1d_error_upper : Array (Quantity .«1») := default
  z_ion_square_1d_error_lower : Array (Quantity .«1») := default
  temperature : Array (Quantity .eV) := default
  temperature_error_upper : Array (Quantity .eV) := default
  temperature_error_lower : Array (Quantity .eV) := default
  temperature_validity : Option Int32 := default
  temperature_fit : Quantity .eV IMAS.«core_profiles/profiles_1d/ion/temperature_fit» := default
  density : Array (Quantity .«m^-3») := default
  density_error_upper : Array (Quantity .«m^-3») := default
  density_error_lower : Array (Quantity .«m^-3») := default
  density_validity : Option Int32 := default
  density_fit : Quantity .«m^-3» IMAS.«core_profiles/profiles_1d/ion/density_fit» := default
  density_thermal : Array (Quantity .«m^-3») := default
  density_thermal_error_upper : Array (Quantity .«m^-3») := default
  density_thermal_error_lower : Array (Quantity .«m^-3») := default
  density_fast : Array (Quantity .«m^-3») := default
  density_fast_error_upper : Array (Quantity .«m^-3») := default
  density_fast_error_lower : Array (Quantity .«m^-3») := default
  pressure : Array (Quantity .Pa) := default
  pressure_error_upper : Array (Quantity .Pa) := default
  pressure_error_lower : Array (Quantity .Pa) := default
  pressure_thermal : Array (Quantity .Pa) := default
  pressure_thermal_error_upper : Array (Quantity .Pa) := default
  pressure_thermal_error_lower : Array (Quantity .Pa) := default
  pressure_fast_perpendicular : Array (Quantity .Pa) := default
  pressure_fast_perpendicular_error_upper : Array (Quantity .Pa) := default
  pressure_fast_perpendicular_error_lower : Array (Quantity .Pa) := default
  pressure_fast_parallel : Array (Quantity .Pa) := default
  pressure_fast_parallel_error_upper : Array (Quantity .Pa) := default
  pressure_fast_parallel_error_lower : Array (Quantity .Pa) := default
  rotation_frequency_tor : Array (Quantity .«rad.s^-1») := default
  rotation_frequency_tor_error_upper : Array (Quantity .«rad.s^-1») := default
  rotation_frequency_tor_error_lower : Array (Quantity .«rad.s^-1») := default
  velocity : Quantity .«m.s^-1» IMAS.«core_profiles/profiles_1d/ion/velocity» := default
  multiple_states_flag : Option Int32 := default
  state : Array IMAS.«core_profiles/profiles_1d/ion/state» := default
  deriving Inhabited

structure «core_profiles/profiles_1d/neutral/element» where
  a : Option (Quantity .u) := default
  a_error_upper : Option (Quantity .u) := default
  a_error_lower : Option (Quantity .u) := default
  z_n : Option (Quantity .e Int32) := default
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
  vibrational_level : Option (Quantity .e) := default
  vibrational_level_error_upper : Option (Quantity .e) := default
  vibrational_level_error_lower : Option (Quantity .e) := default
  vibrational_mode : Option String := default
  neutral_type : IMAS.«core_profiles/profiles_1d/neutral/state/neutral_type» := default
  temperature : Array (Quantity .eV) := default
  temperature_error_upper : Array (Quantity .eV) := default
  temperature_error_lower : Array (Quantity .eV) := default
  density : Array (Quantity .«m^-3») := default
  density_error_upper : Array (Quantity .«m^-3») := default
  density_error_lower : Array (Quantity .«m^-3») := default
  density_thermal : Array (Quantity .«m^-3») := default
  density_thermal_error_upper : Array (Quantity .«m^-3») := default
  density_thermal_error_lower : Array (Quantity .«m^-3») := default
  density_fast : Array (Quantity .«m^-3») := default
  density_fast_error_upper : Array (Quantity .«m^-3») := default
  density_fast_error_lower : Array (Quantity .«m^-3») := default
  pressure : Array (Quantity .Pa) := default
  pressure_error_upper : Array (Quantity .Pa) := default
  pressure_error_lower : Array (Quantity .Pa) := default
  pressure_thermal : Array (Quantity .Pa) := default
  pressure_thermal_error_upper : Array (Quantity .Pa) := default
  pressure_thermal_error_lower : Array (Quantity .Pa) := default
  pressure_fast_perpendicular : Array (Quantity .Pa) := default
  pressure_fast_perpendicular_error_upper : Array (Quantity .Pa) := default
  pressure_fast_perpendicular_error_lower : Array (Quantity .Pa) := default
  pressure_fast_parallel : Array (Quantity .Pa) := default
  pressure_fast_parallel_error_upper : Array (Quantity .Pa) := default
  pressure_fast_parallel_error_lower : Array (Quantity .Pa) := default
  deriving Inhabited

structure «core_profiles/profiles_1d/neutral» where
  element : Array IMAS.«core_profiles/profiles_1d/neutral/element» := default
  name : Option String := default
  ion_index : Option Int32 := default
  temperature : Array (Quantity .eV) := default
  temperature_error_upper : Array (Quantity .eV) := default
  temperature_error_lower : Array (Quantity .eV) := default
  density : Array (Quantity .«m^-3») := default
  density_error_upper : Array (Quantity .«m^-3») := default
  density_error_lower : Array (Quantity .«m^-3») := default
  density_thermal : Array (Quantity .«m^-3») := default
  density_thermal_error_upper : Array (Quantity .«m^-3») := default
  density_thermal_error_lower : Array (Quantity .«m^-3») := default
  density_fast : Array (Quantity .«m^-3») := default
  density_fast_error_upper : Array (Quantity .«m^-3») := default
  density_fast_error_lower : Array (Quantity .«m^-3») := default
  pressure : Array (Quantity .Pa) := default
  pressure_error_upper : Array (Quantity .Pa) := default
  pressure_error_lower : Array (Quantity .Pa) := default
  pressure_thermal : Array (Quantity .Pa) := default
  pressure_thermal_error_upper : Array (Quantity .Pa) := default
  pressure_thermal_error_lower : Array (Quantity .Pa) := default
  pressure_fast_perpendicular : Array (Quantity .Pa) := default
  pressure_fast_perpendicular_error_upper : Array (Quantity .Pa) := default
  pressure_fast_perpendicular_error_lower : Array (Quantity .Pa) := default
  pressure_fast_parallel : Array (Quantity .Pa) := default
  pressure_fast_parallel_error_upper : Array (Quantity .Pa) := default
  pressure_fast_parallel_error_lower : Array (Quantity .Pa) := default
  multiple_states_flag : Option Int32 := default
  state : Array IMAS.«core_profiles/profiles_1d/neutral/state» := default
  deriving Inhabited

structure «core_profiles/profiles_1d/t_i_average_fit/time_measurement_slice_method» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/t_i_average_fit» where
  measured : Array (Quantity .mixed) := default
  measured_error_upper : Array (Quantity .mixed) := default
  measured_error_lower : Array (Quantity .mixed) := default
  source : Array String := default
  time_measurement : Array (Quantity .s) := default
  time_measurement_error_upper : Array (Quantity .s) := default
  time_measurement_error_lower : Array (Quantity .s) := default
  time_measurement_slice_method : IMAS.«core_profiles/profiles_1d/t_i_average_fit/time_measurement_slice_method» := default
  time_measurement_width : Array (Quantity .s) := default
  time_measurement_width_error_upper : Array (Quantity .s) := default
  time_measurement_width_error_lower : Array (Quantity .s) := default
  «local» : Array Int32 := default
  rho_tor_norm : Array (Quantity .«1») := default
  rho_tor_norm_error_upper : Array (Quantity .«1») := default
  rho_tor_norm_error_lower : Array (Quantity .«1») := default
  weight : Array (Quantity .«1») := default
  weight_error_upper : Array (Quantity .«1») := default
  weight_error_lower : Array (Quantity .«1») := default
  reconstructed : Array (Quantity .mixed) := default
  reconstructed_error_upper : Array (Quantity .mixed) := default
  reconstructed_error_lower : Array (Quantity .mixed) := default
  chi_squared : Array (Quantity .«1») := default
  chi_squared_error_upper : Array (Quantity .«1») := default
  chi_squared_error_lower : Array (Quantity .«1») := default
  parameters : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/zeff_fit/time_measurement_slice_method» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/zeff_fit» where
  measured : Array (Quantity .mixed) := default
  measured_error_upper : Array (Quantity .mixed) := default
  measured_error_lower : Array (Quantity .mixed) := default
  source : Array String := default
  time_measurement : Array (Quantity .s) := default
  time_measurement_error_upper : Array (Quantity .s) := default
  time_measurement_error_lower : Array (Quantity .s) := default
  time_measurement_slice_method : IMAS.«core_profiles/profiles_1d/zeff_fit/time_measurement_slice_method» := default
  time_measurement_width : Array (Quantity .s) := default
  time_measurement_width_error_upper : Array (Quantity .s) := default
  time_measurement_width_error_lower : Array (Quantity .s) := default
  «local» : Array Int32 := default
  rho_tor_norm : Array (Quantity .«1») := default
  rho_tor_norm_error_upper : Array (Quantity .«1») := default
  rho_tor_norm_error_lower : Array (Quantity .«1») := default
  weight : Array (Quantity .«1») := default
  weight_error_upper : Array (Quantity .«1») := default
  weight_error_lower : Array (Quantity .«1») := default
  reconstructed : Array (Quantity .mixed) := default
  reconstructed_error_upper : Array (Quantity .mixed) := default
  reconstructed_error_lower : Array (Quantity .mixed) := default
  chi_squared : Array (Quantity .«1») := default
  chi_squared_error_upper : Array (Quantity .«1») := default
  chi_squared_error_lower : Array (Quantity .«1») := default
  parameters : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_1d/e_field» where
  radial : Array (Quantity .«V.m^-1») := default
  radial_error_upper : Array (Quantity .«V.m^-1») := default
  radial_error_lower : Array (Quantity .«V.m^-1») := default
  diamagnetic : Array (Quantity .«V.m^-1») := default
  diamagnetic_error_upper : Array (Quantity .«V.m^-1») := default
  diamagnetic_error_lower : Array (Quantity .«V.m^-1») := default
  parallel : Array (Quantity .«V.m^-1») := default
  parallel_error_upper : Array (Quantity .«V.m^-1») := default
  parallel_error_lower : Array (Quantity .«V.m^-1») := default
  poloidal : Array (Quantity .«V.m^-1») := default
  poloidal_error_upper : Array (Quantity .«V.m^-1») := default
  poloidal_error_lower : Array (Quantity .«V.m^-1») := default
  toroidal : Array (Quantity .«V.m^-1») := default
  toroidal_error_upper : Array (Quantity .«V.m^-1») := default
  toroidal_error_lower : Array (Quantity .«V.m^-1») := default
  deriving Inhabited

structure «core_profiles/profiles_1d» where
  grid : IMAS.«core_profiles/profiles_1d/grid» := default
  electrons : IMAS.«core_profiles/profiles_1d/electrons» := default
  ion : Array IMAS.«core_profiles/profiles_1d/ion» := default
  neutral : Array IMAS.«core_profiles/profiles_1d/neutral» := default
  t_i_average : Array (Quantity .eV) := default
  t_i_average_error_upper : Array (Quantity .eV) := default
  t_i_average_error_lower : Array (Quantity .eV) := default
  t_i_average_fit : Quantity .eV IMAS.«core_profiles/profiles_1d/t_i_average_fit» := default
  n_i_total_over_n_e : Array (Quantity .«1») := default
  n_i_total_over_n_e_error_upper : Array (Quantity .«1») := default
  n_i_total_over_n_e_error_lower : Array (Quantity .«1») := default
  n_i_thermal_total : Array (Quantity .«m^-3») := default
  n_i_thermal_total_error_upper : Array (Quantity .«m^-3») := default
  n_i_thermal_total_error_lower : Array (Quantity .«m^-3») := default
  momentum_phi : Array (Quantity .«kg.m^-1.s^-1») := default
  momentum_phi_error_upper : Array (Quantity .«kg.m^-1.s^-1») := default
  momentum_phi_error_lower : Array (Quantity .«kg.m^-1.s^-1») := default
  zeff : Array (Quantity .«1») := default
  zeff_error_upper : Array (Quantity .«1») := default
  zeff_error_lower : Array (Quantity .«1») := default
  zeff_fit : Quantity .«1» IMAS.«core_profiles/profiles_1d/zeff_fit» := default
  pressure_ion_total : Array (Quantity .Pa) := default
  pressure_ion_total_error_upper : Array (Quantity .Pa) := default
  pressure_ion_total_error_lower : Array (Quantity .Pa) := default
  pressure_thermal : Array (Quantity .Pa) := default
  pressure_thermal_error_upper : Array (Quantity .Pa) := default
  pressure_thermal_error_lower : Array (Quantity .Pa) := default
  pressure_perpendicular : Array (Quantity .Pa) := default
  pressure_perpendicular_error_upper : Array (Quantity .Pa) := default
  pressure_perpendicular_error_lower : Array (Quantity .Pa) := default
  pressure_parallel : Array (Quantity .Pa) := default
  pressure_parallel_error_upper : Array (Quantity .Pa) := default
  pressure_parallel_error_lower : Array (Quantity .Pa) := default
  j_total : Array (Quantity .«A.m^-2») := default
  j_total_error_upper : Array (Quantity .«A.m^-2») := default
  j_total_error_lower : Array (Quantity .«A.m^-2») := default
  current_parallel_inside : Array (Quantity .A) := default
  current_parallel_inside_error_upper : Array (Quantity .A) := default
  current_parallel_inside_error_lower : Array (Quantity .A) := default
  j_phi : Array (Quantity .«A.m^-2») := default
  j_phi_error_upper : Array (Quantity .«A.m^-2») := default
  j_phi_error_lower : Array (Quantity .«A.m^-2») := default
  j_ohmic : Array (Quantity .«A.m^-2») := default
  j_ohmic_error_upper : Array (Quantity .«A.m^-2») := default
  j_ohmic_error_lower : Array (Quantity .«A.m^-2») := default
  j_non_inductive : Array (Quantity .«A.m^-2») := default
  j_non_inductive_error_upper : Array (Quantity .«A.m^-2») := default
  j_non_inductive_error_lower : Array (Quantity .«A.m^-2») := default
  j_bootstrap : Array (Quantity .«A.m^-2») := default
  j_bootstrap_error_upper : Array (Quantity .«A.m^-2») := default
  j_bootstrap_error_lower : Array (Quantity .«A.m^-2») := default
  conductivity_parallel : Array (Quantity .«ohm^-1.m^-1») := default
  conductivity_parallel_error_upper : Array (Quantity .«ohm^-1.m^-1») := default
  conductivity_parallel_error_lower : Array (Quantity .«ohm^-1.m^-1») := default
  e_field : Quantity .«V.m^-1» IMAS.«core_profiles/profiles_1d/e_field» := default
  phi_potential : Array (Quantity .V) := default
  phi_potential_error_upper : Array (Quantity .V) := default
  phi_potential_error_lower : Array (Quantity .V) := default
  rotation_frequency_tor_sonic : Array (Quantity .«s^-1») := default
  rotation_frequency_tor_sonic_error_upper : Array (Quantity .«s^-1») := default
  rotation_frequency_tor_sonic_error_lower : Array (Quantity .«s^-1») := default
  q : Array (Quantity .«1») := default
  q_error_upper : Array (Quantity .«1») := default
  q_error_lower : Array (Quantity .«1») := default
  magnetic_shear : Array (Quantity .«1») := default
  magnetic_shear_error_upper : Array (Quantity .«1») := default
  magnetic_shear_error_lower : Array (Quantity .«1») := default
  time : Option (Quantity .s) := default
  deriving Inhabited

structure «core_profiles/profiles_2d/grid_type» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/profiles_2d/grid» where
  dim1 : Array (Quantity .mixed) := default
  dim1_error_upper : Array (Quantity .mixed) := default
  dim1_error_lower : Array (Quantity .mixed) := default
  dim2 : Array (Quantity .mixed) := default
  dim2_error_upper : Array (Quantity .mixed) := default
  dim2_error_lower : Array (Quantity .mixed) := default
  volume_element : Matrix (Quantity .«m^3») := default
  volume_element_error_upper : Matrix (Quantity .«m^3») := default
  volume_element_error_lower : Matrix (Quantity .«m^3») := default
  deriving Inhabited

structure «core_profiles/profiles_2d/ion/element» where
  a : Option (Quantity .u) := default
  a_error_upper : Option (Quantity .u) := default
  a_error_lower : Option (Quantity .u) := default
  z_n : Option (Quantity .e Int32) := default
  atoms_n : Option Int32 := default
  deriving Inhabited

structure «core_profiles/profiles_2d/ion/velocity» where
  radial : Matrix (Quantity .«m.s^-1») := default
  radial_error_upper : Matrix (Quantity .«m.s^-1») := default
  radial_error_lower : Matrix (Quantity .«m.s^-1») := default
  diamagnetic : Matrix (Quantity .«m.s^-1») := default
  diamagnetic_error_upper : Matrix (Quantity .«m.s^-1») := default
  diamagnetic_error_lower : Matrix (Quantity .«m.s^-1») := default
  parallel : Matrix (Quantity .«m.s^-1») := default
  parallel_error_upper : Matrix (Quantity .«m.s^-1») := default
  parallel_error_lower : Matrix (Quantity .«m.s^-1») := default
  poloidal : Matrix (Quantity .«m.s^-1») := default
  poloidal_error_upper : Matrix (Quantity .«m.s^-1») := default
  poloidal_error_lower : Matrix (Quantity .«m.s^-1») := default
  toroidal : Matrix (Quantity .«m.s^-1») := default
  toroidal_error_upper : Matrix (Quantity .«m.s^-1») := default
  toroidal_error_lower : Matrix (Quantity .«m.s^-1») := default
  deriving Inhabited

structure «core_profiles/profiles_2d/ion/state» where
  z_min : Option (Quantity .e) := default
  z_min_error_upper : Option (Quantity .e) := default
  z_min_error_lower : Option (Quantity .e) := default
  z_max : Option (Quantity .e) := default
  z_max_error_upper : Option (Quantity .e) := default
  z_max_error_lower : Option (Quantity .e) := default
  z_average : Option (Quantity .e) := default
  z_average_error_upper : Option (Quantity .e) := default
  z_average_error_lower : Option (Quantity .e) := default
  z_square_average : Option (Quantity .e) := default
  z_square_average_error_upper : Option (Quantity .e) := default
  z_square_average_error_lower : Option (Quantity .e) := default
  ionization_potential : Option (Quantity .eV) := default
  ionization_potential_error_upper : Option (Quantity .eV) := default
  ionization_potential_error_lower : Option (Quantity .eV) := default
  name : Option String := default
  electron_configuration : Option String := default
  vibrational_level : Option (Quantity .e) := default
  vibrational_level_error_upper : Option (Quantity .e) := default
  vibrational_level_error_lower : Option (Quantity .e) := default
  vibrational_mode : Option String := default
  rotation_frequency_tor : Matrix (Quantity .«rad.s^-1») := default
  rotation_frequency_tor_error_upper : Matrix (Quantity .«rad.s^-1») := default
  rotation_frequency_tor_error_lower : Matrix (Quantity .«rad.s^-1») := default
  temperature : Matrix (Quantity .eV) := default
  temperature_error_upper : Matrix (Quantity .eV) := default
  temperature_error_lower : Matrix (Quantity .eV) := default
  density : Matrix (Quantity .«m^-3») := default
  density_error_upper : Matrix (Quantity .«m^-3») := default
  density_error_lower : Matrix (Quantity .«m^-3») := default
  density_thermal : Matrix (Quantity .«m^-3») := default
  density_thermal_error_upper : Matrix (Quantity .«m^-3») := default
  density_thermal_error_lower : Matrix (Quantity .«m^-3») := default
  density_fast : Matrix (Quantity .«m^-3») := default
  density_fast_error_upper : Matrix (Quantity .«m^-3») := default
  density_fast_error_lower : Matrix (Quantity .«m^-3») := default
  pressure : Matrix (Quantity .Pa) := default
  pressure_error_upper : Matrix (Quantity .Pa) := default
  pressure_error_lower : Matrix (Quantity .Pa) := default
  pressure_thermal : Matrix (Quantity .Pa) := default
  pressure_thermal_error_upper : Matrix (Quantity .Pa) := default
  pressure_thermal_error_lower : Matrix (Quantity .Pa) := default
  pressure_fast_perpendicular : Matrix (Quantity .Pa) := default
  pressure_fast_perpendicular_error_upper : Matrix (Quantity .Pa) := default
  pressure_fast_perpendicular_error_lower : Matrix (Quantity .Pa) := default
  pressure_fast_parallel : Matrix (Quantity .Pa) := default
  pressure_fast_parallel_error_upper : Matrix (Quantity .Pa) := default
  pressure_fast_parallel_error_lower : Matrix (Quantity .Pa) := default
  deriving Inhabited

structure «core_profiles/profiles_2d/ion» where
  element : Array IMAS.«core_profiles/profiles_2d/ion/element» := default
  z_ion : Option (Quantity .e) := default
  z_ion_error_upper : Option (Quantity .e) := default
  z_ion_error_lower : Option (Quantity .e) := default
  name : Option String := default
  ion_index : Option Int32 := default
  temperature : Matrix (Quantity .eV) := default
  temperature_error_upper : Matrix (Quantity .eV) := default
  temperature_error_lower : Matrix (Quantity .eV) := default
  density : Matrix (Quantity .«m^-3») := default
  density_error_upper : Matrix (Quantity .«m^-3») := default
  density_error_lower : Matrix (Quantity .«m^-3») := default
  density_thermal : Matrix (Quantity .«m^-3») := default
  density_thermal_error_upper : Matrix (Quantity .«m^-3») := default
  density_thermal_error_lower : Matrix (Quantity .«m^-3») := default
  density_fast : Matrix (Quantity .«m^-3») := default
  density_fast_error_upper : Matrix (Quantity .«m^-3») := default
  density_fast_error_lower : Matrix (Quantity .«m^-3») := default
  pressure : Matrix (Quantity .Pa) := default
  pressure_error_upper : Matrix (Quantity .Pa) := default
  pressure_error_lower : Matrix (Quantity .Pa) := default
  pressure_thermal : Matrix (Quantity .Pa) := default
  pressure_thermal_error_upper : Matrix (Quantity .Pa) := default
  pressure_thermal_error_lower : Matrix (Quantity .Pa) := default
  pressure_fast_perpendicular : Matrix (Quantity .Pa) := default
  pressure_fast_perpendicular_error_upper : Matrix (Quantity .Pa) := default
  pressure_fast_perpendicular_error_lower : Matrix (Quantity .Pa) := default
  pressure_fast_parallel : Matrix (Quantity .Pa) := default
  pressure_fast_parallel_error_upper : Matrix (Quantity .Pa) := default
  pressure_fast_parallel_error_lower : Matrix (Quantity .Pa) := default
  rotation_frequency_tor : Matrix (Quantity .«rad.s^-1») := default
  rotation_frequency_tor_error_upper : Matrix (Quantity .«rad.s^-1») := default
  rotation_frequency_tor_error_lower : Matrix (Quantity .«rad.s^-1») := default
  velocity : Quantity .«m.s^-1» IMAS.«core_profiles/profiles_2d/ion/velocity» := default
  multiple_states_flag : Option Int32 := default
  state : Array IMAS.«core_profiles/profiles_2d/ion/state» := default
  deriving Inhabited

structure «core_profiles/profiles_2d» where
  grid_type : IMAS.«core_profiles/profiles_2d/grid_type» := default
  grid : IMAS.«core_profiles/profiles_2d/grid» := default
  ion : Array IMAS.«core_profiles/profiles_2d/ion» := default
  t_i_average : Matrix (Quantity .eV) := default
  t_i_average_error_upper : Matrix (Quantity .eV) := default
  t_i_average_error_lower : Matrix (Quantity .eV) := default
  n_i_total_over_n_e : Matrix (Quantity .«1») := default
  n_i_total_over_n_e_error_upper : Matrix (Quantity .«1») := default
  n_i_total_over_n_e_error_lower : Matrix (Quantity .«1») := default
  n_i_thermal_total : Matrix (Quantity .«m^-3») := default
  n_i_thermal_total_error_upper : Matrix (Quantity .«m^-3») := default
  n_i_thermal_total_error_lower : Matrix (Quantity .«m^-3») := default
  momentum_phi : Matrix (Quantity .«kg.m^-1.s^-1») := default
  momentum_phi_error_upper : Matrix (Quantity .«kg.m^-1.s^-1») := default
  momentum_phi_error_lower : Matrix (Quantity .«kg.m^-1.s^-1») := default
  zeff : Matrix (Quantity .«1») := default
  zeff_error_upper : Matrix (Quantity .«1») := default
  zeff_error_lower : Matrix (Quantity .«1») := default
  pressure_ion_total : Matrix (Quantity .Pa) := default
  pressure_ion_total_error_upper : Matrix (Quantity .Pa) := default
  pressure_ion_total_error_lower : Matrix (Quantity .Pa) := default
  pressure_thermal : Matrix (Quantity .Pa) := default
  pressure_thermal_error_upper : Matrix (Quantity .Pa) := default
  pressure_thermal_error_lower : Matrix (Quantity .Pa) := default
  pressure_perpendicular : Matrix (Quantity .Pa) := default
  pressure_perpendicular_error_upper : Matrix (Quantity .Pa) := default
  pressure_perpendicular_error_lower : Matrix (Quantity .Pa) := default
  pressure_parallel : Matrix (Quantity .Pa) := default
  pressure_parallel_error_upper : Matrix (Quantity .Pa) := default
  pressure_parallel_error_lower : Matrix (Quantity .Pa) := default
  time : Option (Quantity .s) := default
  deriving Inhabited

structure «core_profiles/global_quantities/ion» where
  t_i_volume_average : Array (Quantity .eV) := default
  t_i_volume_average_error_upper : Array (Quantity .eV) := default
  t_i_volume_average_error_lower : Array (Quantity .eV) := default
  n_i_volume_average : Array (Quantity .«m^-3») := default
  n_i_volume_average_error_upper : Array (Quantity .«m^-3») := default
  n_i_volume_average_error_lower : Array (Quantity .«m^-3») := default
  deriving Inhabited

structure «core_profiles/global_quantities» where
  ip : Array (Quantity .A) := default
  ip_error_upper : Array (Quantity .A) := default
  ip_error_lower : Array (Quantity .A) := default
  current_non_inductive : Array (Quantity .A) := default
  current_non_inductive_error_upper : Array (Quantity .A) := default
  current_non_inductive_error_lower : Array (Quantity .A) := default
  current_bootstrap : Array (Quantity .A) := default
  current_bootstrap_error_upper : Array (Quantity .A) := default
  current_bootstrap_error_lower : Array (Quantity .A) := default
  v_loop : Array (Quantity .V) := default
  v_loop_error_upper : Array (Quantity .V) := default
  v_loop_error_lower : Array (Quantity .V) := default
  li_3 : Array (Quantity .«1») := default
  li_3_error_upper : Array (Quantity .«1») := default
  li_3_error_lower : Array (Quantity .«1») := default
  beta_tor : Array (Quantity .«1») := default
  beta_tor_error_upper : Array (Quantity .«1») := default
  beta_tor_error_lower : Array (Quantity .«1») := default
  beta_tor_norm : Array (Quantity .«1») := default
  beta_tor_norm_error_upper : Array (Quantity .«1») := default
  beta_tor_norm_error_lower : Array (Quantity .«1») := default
  beta_pol : Array (Quantity .«1») := default
  beta_pol_error_upper : Array (Quantity .«1») := default
  beta_pol_error_lower : Array (Quantity .«1») := default
  energy_diamagnetic : Array (Quantity .J) := default
  energy_diamagnetic_error_upper : Array (Quantity .J) := default
  energy_diamagnetic_error_lower : Array (Quantity .J) := default
  z_eff_resistive : Array (Quantity .«1») := default
  z_eff_resistive_error_upper : Array (Quantity .«1») := default
  z_eff_resistive_error_lower : Array (Quantity .«1») := default
  t_e_peaking : Array (Quantity .«1») := default
  t_e_peaking_error_upper : Array (Quantity .«1») := default
  t_e_peaking_error_lower : Array (Quantity .«1») := default
  t_i_average_peaking : Array (Quantity .«1») := default
  t_i_average_peaking_error_upper : Array (Quantity .«1») := default
  t_i_average_peaking_error_lower : Array (Quantity .«1») := default
  resistive_psi_losses : Array (Quantity .Wb) := default
  resistive_psi_losses_error_upper : Array (Quantity .Wb) := default
  resistive_psi_losses_error_lower : Array (Quantity .Wb) := default
  ejima : Array (Quantity .«1») := default
  ejima_error_upper : Array (Quantity .«1») := default
  ejima_error_lower : Array (Quantity .«1») := default
  t_e_volume_average : Array (Quantity .eV) := default
  t_e_volume_average_error_upper : Array (Quantity .eV) := default
  t_e_volume_average_error_lower : Array (Quantity .eV) := default
  n_e_volume_average : Array (Quantity .«m^-3») := default
  n_e_volume_average_error_upper : Array (Quantity .«m^-3») := default
  n_e_volume_average_error_lower : Array (Quantity .«m^-3») := default
  ion : Array IMAS.«core_profiles/global_quantities/ion» := default
  ion_time_slice : Option (Quantity .s) := default
  ion_time_slice_error_upper : Option (Quantity .s) := default
  ion_time_slice_error_lower : Option (Quantity .s) := default
  deriving Inhabited

structure «core_profiles/vacuum_toroidal_field» where
  r0 : Option (Quantity .m) := default
  r0_error_upper : Option (Quantity .m) := default
  r0_error_lower : Option (Quantity .m) := default
  b0 : Array (Quantity .T) := default
  b0_error_upper : Array (Quantity .T) := default
  b0_error_lower : Array (Quantity .T) := default
  deriving Inhabited

structure «core_profiles/covariance» where
  description : Option String := default
  rows_uri : Array String := default
  data : Matrix (Quantity .mixed) := default
  data_error_upper : Matrix (Quantity .mixed) := default
  data_error_lower : Matrix (Quantity .mixed) := default
  deriving Inhabited

structure «core_profiles/statistics/quantity_2d/statistics_type/identifier» where
  name : Option String := default
  index : Option Int32 := default
  description : Option String := default
  deriving Inhabited

structure «core_profiles/statistics/quantity_2d/statistics_type» where
  identifier : IMAS.«core_profiles/statistics/quantity_2d/statistics_type/identifier» := default
  value : Array (Quantity .mixed) := default
  value_error_upper : Array (Quantity .mixed) := default
  value_error_lower : Array (Quantity .mixed) := default
  grid_subset_index : Option Int32 := default
  grid_index : Option Int32 := default
  uq_input_path : Option Int32 := default
  deriving Inhabited

structure «core_profiles/statistics/quantity_2d/distribution» where
  bins : Matrix (Quantity .mixed) := default
  bins_error_upper : Matrix (Quantity .mixed) := default
  bins_error_lower : Matrix (Quantity .mixed) := default
  probability : Matrix (Quantity .«1») := default
  probability_error_upper : Matrix (Quantity .«1») := default
  probability_error_lower : Matrix (Quantity .«1») := default
  deriving Inhabited

structure «core_profiles/statistics/quantity_2d» where
  path : Option String := default
  statistics_type : Array IMAS.«core_profiles/statistics/quantity_2d/statistics_type» := default
  distribution : IMAS.«core_profiles/statistics/quantity_2d/distribution» := default
  deriving Inhabited

structure «core_profiles/statistics/uq_input_2d/distribution» where
  bins : Matrix (Quantity .mixed) := default
  bins_error_upper : Matrix (Quantity .mixed) := default
  bins_error_lower : Matrix (Quantity .mixed) := default
  probability : Matrix (Quantity .«1») := default
  probability_error_upper : Matrix (Quantity .«1») := default
  probability_error_lower : Matrix (Quantity .«1») := default
  deriving Inhabited

structure «core_profiles/statistics/uq_input_2d» where
  path : Option String := default
  distribution : IMAS.«core_profiles/statistics/uq_input_2d/distribution» := default
  deriving Inhabited

structure «core_profiles/statistics» where
  quantity_2d : Array IMAS.«core_profiles/statistics/quantity_2d» := default
  uq_input_2d : Array IMAS.«core_profiles/statistics/uq_input_2d» := default
  time_width : Option (Quantity .s) := default
  time_width_error_upper : Option (Quantity .s) := default
  time_width_error_lower : Option (Quantity .s) := default
  time : Option (Quantity .s) := default
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
  time : Array (Quantity .s) := default
  deriving Inhabited

end IMAS
