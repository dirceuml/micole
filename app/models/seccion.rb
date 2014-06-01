class Seccion < ActiveRecord::Base
  belongs_to :grado
  has_many :anios_alumnos
  has_many :alumnos, :through => :anios_alumnos
  has_one :anio_escolar, :through => :grado
  has_many :actividades_secciones
  has_many :actividades, :through => :actividades_secciones
  has_many :usuarios_secciones
  has_many :cuadernos_controles
  
  validates :grado_id, :seccion, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  
  scope :por_anioescolar, lambda { |anioescolar| joins(:grado).where("grados.anio_escolar_id = ?", anioescolar)}
  scope :por_anioescolar_usuario, lambda { |anioescolar, usuarioadm| joins(:grado).joins(:usuarios_secciones).where("grados.anio_escolar_id = ? and usuarios_secciones.usuario_id = ?", anioescolar, usuarioadm)}
  scope :con_cuaderno_control, lambda { |fecha| joins(:cuadernos_controles).where("cuadernos_controles.fecha = ?", fecha) }
  scope :sin_cuaderno_control, lambda { |fecha| Seccion.find(Seccion.pluck(:id) - self.con_cuaderno_control(fecha).pluck(:seccion_id).map { |i| i.to_i }) }
  
  def grado_seccion
    grado.grado.to_s + " " + seccion + " " + grado.nivel_desc
  end
end
