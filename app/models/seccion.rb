class Seccion < ActiveRecord::Base
  belongs_to :grado
  has_many :anios_alumnos
  has_many :actividades_secciones
  has_many :actividades, :through => :actividades_secciones
  
  validates :seccion, :usuario, :presence => true
  
  def grado_seccion
    grado.grado.to_s + " " + seccion
  end
end
