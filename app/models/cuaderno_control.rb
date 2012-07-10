class CuadernoControl < ActiveRecord::Base
  has_many :cuadernos_controles_eventos
  has_many :cuadernos_controles_revisiones
  belongs_to :seccion
  
  validates :seccion_id, :fecha, :estado, :usuario, :presence => true
end
