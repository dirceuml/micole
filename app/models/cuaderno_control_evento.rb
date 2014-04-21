class CuadernoControlEvento < ActiveRecord::Base
  belongs_to :cuaderno_control
  belongs_to :tipo_evento
  belongs_to :alumno
  has_many :alumno_persona_vinculada, :through => :alumno
  
  validates :cuaderno_control_id, :tipo_evento_id, :descripcion, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  
  # se ha actualizado estos scopes colocando el parametro "anioescolar", pero nadie los usa.
  scope :cerrado, lambda { |anioescolar| joins(:cuaderno_control => {:seccion => :grado}).where("grados.anio_escolar_id = ? and cuadernos_controles.estado = 2", anioescolar)}
  scope :abierto, lambda { |anioescolar| joins(:cuaderno_control => {:seccion => :grado}).where("grados.anio_escolar_id = ? and cuadernos_controles.estado = 1", anioescolar)}
  
end
