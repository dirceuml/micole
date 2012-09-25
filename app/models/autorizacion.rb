class Autorizacion < ActiveRecord::Base
  belongs_to :actividad
  belongs_to :alumno
  belongs_to :persona_vinculada
  
  scope :pendiente, where(:respuesta => nil)
  scope :respondida, where(:respuesta => [0,1])
  scope :vigente, lambda { joins(:actividad).where("to_char(actividades.limite_autorizacion, 'yyyymmdd') >= ?", Time.now.strftime('%Y%m%d'))}
  scope :pasado, lambda { joins(:actividad).where("to_char(actividades.limite_autorizacion, 'yyyymmdd') < ?", Time.now.strftime('%Y%m%d'))}
  scope :persona, lambda { |persona| joins(:persona_vinculada).where("personas_vincualadas.id = ?", persona)}
  scope :persona_autorizada, lambda { |autorizado| joins(:alumno => :alumnos_personas_vinculadas).where("autoriza_actividad = 1 and alumnos_personas_vinculadas.persona_vinculada_id = ?", autorizado) }
  
end
