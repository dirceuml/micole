class Autorizacion < ActiveRecord::Base
  belongs_to :actividad
  belongs_to :alumno
  belongs_to :persona_vinculada
  
  validates :alumno_id, :uniqueness => { :scope => :actividad_id, :message => " ya esta vinculado con la actividad." }
  
  scope :pendiente, where(:respuesta => nil)
  scope :autorizado, where(:respuesta => 1)
  scope :no_autorizado, where(:respuesta => 0)
  scope :respondido, where(:respuesta => [0,1])
  scope :vigente, lambda { joins(:actividad).where("to_char(actividades.limite_autorizacion, 'yyyymmdd') >= ? and ((respuesta is NULL and actividades.estado = 2) or respuesta is not NULL)", Date.current.strftime('%Y%m%d'))}
  scope :pasado, lambda { joins(:actividad).where("to_char(actividades.limite_autorizacion, 'yyyymmdd') < ? and ((respuesta is NULL and actividades.estado = 2) or respuesta is not NULL)", Date.current.strftime('%Y%m%d'))}
  scope :persona_autorizada, lambda { |persona| joins(:alumno => :alumnos_personas_vinculadas).where("autoriza_actividad = 1 and alumnos_personas_vinculadas.persona_vinculada_id = ?", persona) }
  scope :por_actividad, lambda { |actividad| where("autorizaciones.actividad_id = ?", actividad)}
  scope :por_seccion, lambda { |anioescolar, seccion| joins(:alumno => :anios_alumnos).where("anio_escolar_id = ? and anios_alumnos.seccion_id = ?", anioescolar, seccion) unless seccion.empty?}
end
