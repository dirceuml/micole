class Seccion < ActiveRecord::Base
  belongs_to :grado
  has_many :anios_alumnos
  has_many :alumnos, :through => :anios_alumnos
  has_one :anio_escolar, :through => :grado
  has_many :actividades_secciones
  has_many :actividades, :through => :actividades_secciones
  has_many :usuarios_secciones
  
  validates :grado_id, :seccion, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  
  scope :por_anioescolar, lambda { |anioescolar| joins(:grado).where("grados.anio_escolar_id = ?", anioescolar)}
  scope :por_anioescolar_usuario, lambda { |anioescolar, usuarioadm| joins(:grado).joins(:usuarios_secciones).where("grados.anio_escolar_id = ? and usuarios_secciones.usuario_id = ?", anioescolar, usuarioadm)}
  #scope :por_anio_y_colegio, lambda { |anio, colegio| joins(:anio_escolar).where("anios_escolares.id = ? and anios_escolares.colegio_id = ?", anio, colegio)}
  #scope :no_asignadas_usuario
  
  def grado_seccion
    grado.grado.to_s + " " + seccion + " " + grado.nivel_desc
  end
end
