class CuadernoControlEvento < ActiveRecord::Base
  belongs_to :cuaderno_control
  belongs_to :tipo_evento
  belongs_to :alumno
  
  validates :cuaderno_control_id, :tipo_evento_id, :descripcion, :usuario, :presence => true
  
  scope :cerrado, joins(:cuaderno_control).where("cuadernos_controles.estado = 2")
  scope :abierto, joins(:cuaderno_control).where("cuadernos_controles.estado = 1")
end
