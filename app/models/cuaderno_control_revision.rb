class CuadernoControlRevision < ActiveRecord::Base
  belongs_to :cuaderno_control
  belongs_to :persona_vinculada
  belongs_to :alumno
  
  validates :cuaderno_control_id, :alumno_id, :persona_vinculada_id, :revisado, :usuario, :presence => true  
  
  scope :revisado, where(:revisado => 1)
  scope :cerrado, joins(:cuaderno_control).where("cuadernos_controles.estado = 2")
  scope :abierto, joins(:cuaderno_control).where("cuadernos_controles.estado = 1")
  scope :se_revisan_por, lambda { |padre| joins(:alumno => :alumnos_personas_vinculadas).where("revisa_control = 1 and alumnos_personas_vinculadas.persona_vinculada_id = ?", padre) }
  scope :verificar, lambda { |seccion,fecha| joins(:cuaderno_control).where("estado = 2 and seccion_id = ? and fecha = ?", seccion, fecha)}
end
