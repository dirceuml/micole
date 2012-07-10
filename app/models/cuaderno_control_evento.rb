class CuadernoControlEvento < ActiveRecord::Base
  belongs_to :cuaderno_control
  belongs_to :tipo_evento
  belongs_to :alumno
  
  validates :cuaderno_control_id, :tipo_evento_id, :descripcion, :usuario, :presence => true
end
