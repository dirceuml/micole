class Seccion < ActiveRecord::Base
  belongs_to :grado
  has_many :anios_alumnos
  has_many :alumnos, :through => :anios_alumnos
  has_many :actividades_secciones
  has_many :actividades, :through => :actividades_secciones
  has_many :usuarios_secciones
  
  validates :grado_id, :seccion, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  
  scope :por_anioescolar, lambda { |anioescolar| joins(:grado).where("grados.anio_escolar_id = ?", anioescolar)}
  scope :por_anioescolar_usuario, lambda { |anioescolar, usuarioadm| joins(:grado).joins(:usuarios_secciones).where("grados.anio_escolar_id = ? and usuarios_secciones.usuario_id = ?", anioescolar, usuarioadm)}
  #scope :por_anio_y_colegio, lambda { |anio, colegio| self.por_anioescolar(anio).joins(:anios_alumnos)}
  #scope :no_asignadas_usuario
  
  def grado_seccion
    grado.grado.to_s + " " + seccion + " " + grado.nivel_desc
  end
end
