class CuadernoControlEvento < ActiveRecord::Base
  belongs_to :cuaderno_control
  belongs_to :tipo_evento
  belongs_to :alumno
  has_many :alumno_persona_vinculada, :through => :alumno
  
  validates :cuaderno_control_id, :tipo_evento_id, :descripcion, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  validate :fecha_evento_valida
  validate :alumno_valida
  
  # se ha actualizado estos scopes colocando el parametro "anioescolar", pero nadie los usa.
  scope :cerrado, lambda { |anioescolar| joins(:cuaderno_control => {:seccion => :grado}).where("grados.anio_escolar_id = ? and cuadernos_controles.estado = 2", anioescolar)}
  scope :abierto, lambda { |anioescolar| joins(:cuaderno_control => {:seccion => :grado}).where("grados.anio_escolar_id = ? and cuadernos_controles.estado = 1", anioescolar)}
  
  scope :pendiente, lambda { |fecha| joins(:cuaderno_control => {:seccion => :grado}).where("fecha_evento is not null and to_char(fecha_evento, 'yyyymmdd') >= ?", fecha.strftime('%Y%m%d'))}
  scope :pasado, lambda { |fecha| joins(:cuaderno_control => {:seccion => :grado}).where("fecha_evento is not null and to_char(fecha_evento, 'yyyymmdd') < ?", fecha.strftime('%Y%m%d'))}
  scope :por_seccion, lambda { |anioescolar, seccion| joins(:cuaderno_control => {:seccion => :grado}).where("grados.anio_escolar_id = ? and secciones.id = ? and cuadernos_controles.estado = 2", anioescolar, seccion)}
  
  def fecha_evento_valida
    if fecha_evento.present?
      if fecha_evento <= Date.current then
        errors.add(:fecha_evento, ": La fecha de evento no puede ser menor o igual a hoy.")
      end
    else
      if TipoEvento.find(tipo_evento_id).obligatorio_fecha == 1
        errors.add(:fecha_evento, ": Ingrese la fecha de programacion.")
      end
    end
  end
  
  def alumno_valida
    if TipoEvento.find(tipo_evento_id).alcance== 3 && alumno_id.nil?
      errors.add(:alumno_id, ": Seleccione un alumno.")
    end
  end
  
end
