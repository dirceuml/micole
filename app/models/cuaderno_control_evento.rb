class CuadernoControlEvento < ActiveRecord::Base
  belongs_to :cuaderno_control
  belongs_to :tipo_evento
  belongs_to :alumno
  has_many :alumno_persona_vinculada, :through => :alumno
  
  validates :cuaderno_control_id, :tipo_evento_id, :descripcion, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  
  scope :cerrado, joins(:cuaderno_control).where("cuadernos_controles.estado = 2")
  scope :abierto, joins(:cuaderno_control).where("cuadernos_controles.estado = 1")
end
