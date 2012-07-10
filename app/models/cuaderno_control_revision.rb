class CuadernoControlRevision < ActiveRecord::Base
  belongs_to :cuaderno_control
  belongs_to :persona_vinculada
  belongs_to :alumno
  
  validates :cuaderno_control_id, :alumno_id, :persona_vinculada_id, :revisado, :usuario, :presence => true
end
