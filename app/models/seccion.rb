class Seccion < ActiveRecord::Base
  belongs_to :grado
  has_many :anios_alumnos
  has_many :alumnos, :through => :anios_alumnos
  has_many :actividades_secciones
  has_many :actividades, :through => :actividades_secciones
  
  validates :grado_id, :seccion, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  
  scope :por_anioescolar, joins(:grado).where("grados.anio_escolar_id = ?", 1)
  
  def grado_seccion
    grado.grado.to_s + " " + seccion
  end
end
