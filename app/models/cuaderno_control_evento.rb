class CuadernoControlEvento < ActiveRecord::Base
  belongs_to :cuaderno_control
  belongs_to :tipo_evento
  belongs_to :alumno
  has_many :alumno_persona_vinculada, :through => :alumno
  
  validates :cuaderno_control_id, :tipo_evento_id, :descripcion, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  
  # se ha actualizado estos scopes colocando el parametro "anioescolar", pero nadie los usa.
  scope :cerrado, lambda { |anioescolar| joins(:cuaderno_control => {:seccion => :grado}).where("grados.anio_escolar_id = ? and cuadernos_controles.estado = 2", anioescolar)}
  scope :abierto, lambda { |anioescolar| joins(:cuaderno_control => {:seccion => :grado}).where("grados.anio_escolar_id = ? and cuadernos_controles.estado = 1", anioescolar)}
  
  scope :pendiente, lambda { |fecha| joins(:cuaderno_control => {:seccion => :grado}).where("fecha_evento is not null and to_char(fecha_evento, 'yyyymmdd') >= ?", fecha.strftime('%Y%m%d'))}
  scope :pasado, lambda { |fecha| joins(:cuaderno_control => {:seccion => :grado}).where("fecha_evento is not null and to_char(fecha_evento, 'yyyymmdd') < ?", fecha.strftime('%Y%m%d'))}
  scope :por_seccion, lambda { |anioescolar, seccion| joins(:cuaderno_control => {:seccion => :grado}).where("grados.anio_escolar_id = ? and secciones.id = ? and cuadernos_controles.estado = 2", anioescolar, seccion)}
end
