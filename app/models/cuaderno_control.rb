class CuadernoControl < ActiveRecord::Base
  has_many :cuaderno_controles_eventos, :dependent => :delete_all
  has_many :cuaderno_controles_revisiones, :dependent => :delete_all
  belongs_to :seccion
  
  validates :seccion_id, :fecha, :estado, :usuario, :presence => true
end
