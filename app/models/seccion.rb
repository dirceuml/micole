class Seccion < ActiveRecord::Base
  belongs_to :grado
  has_many :anios_alumnos
  
  validates :seccion, :usuario, :presence => true
  
  def grado_seccion
    grado.grado.to_s + " " + seccion
  end
end
