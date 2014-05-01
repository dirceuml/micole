class Seccion < ActiveRecord::Base
  belongs_to :grado
  has_many :anios_alumnos
  has_many :alumnos, :through => :anios_alumnos
  has_many :actividades_secciones
  has_many :actividades, :through => :actividades_secciones
  
  validates :grado_id, :seccion, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  
  scope :por_anioescolar, lambda { |anioescolar| joins(:grado).where("grados.anio_escolar_id = ?", anioescolar)}
  
  def grado_seccion
    grado.grado.to_s + " " + seccion + " " + grado.nivel_desc
  end
end
