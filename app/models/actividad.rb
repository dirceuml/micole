class Actividad < ActiveRecord::Base
  belongs_to :anio_escolar
  belongs_to :tipo_evento
  has_many :autorizaciones
  
  validates :anio_escolar_id, :tipo_evento_id, :fecha_hora_inicio, :fecha_hora_fin, :presence => { :message => ": El campo no puede estar vacio" }
  validates :tipo_actividad, :nombre, :detalle, :requiere_autorizacion, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  validates_format_of :hora_inicio, :with => /\d{1,2}:\d{2}/, :message => "invalido"
  validates_format_of :hora_fin, :with => /\d{1,2}:\d{2}/, :message => "invalido"
  
  scope :pendiente, lambda { |fecha| where("to_char(fecha_hora_fin, 'yyyymmdd') >= ?", fecha.strftime('%Y%m%d'))}
  scope :realizada, lambda { |fecha| where("to_char(fecha_hora_fin, 'yyyymmdd') < ?", fecha.strftime('%Y%m%d'))}
  #  DateTime.current fecha_hora_fin < DateTime.current
  
  scope :por_fecha_inicio, lambda { |fecha| where("to_char(fecha_hora_inicio, 'dd/mm/yyyy') = ?", fecha.strftime('%d/%m/%Y'))}
  
  
#  attr_accessible :anio_escolar_id, :tipo_evento_id, :fecha_hora_inicio, :fecha_hora_fin, :tipo_actividad
#  attr_accessible :nombre, :detalle, :requiere_autorizacion, :limite_autorizacion, :inicio_notificacion, :fin_notificacion
#  attr_accessible :frecuencia_dias_notificacion, :fecha_inicio, :hora_inicio 
  attr_accessor :fecha_inicio, :hora_inicio, :fecha_fin, :hora_fin
  
  after_initialize :get_datetime_inicio, :get_datetime_fin
  before_validation :set_datetime_inicio, :set_datetime_fin
  
  def get_datetime_inicio
    if !self.fecha_hora_inicio.nil?
      self.fecha_inicio ||= self.fecha_hora_inicio.to_date.to_s(:db)
      self.hora_inicio  ||= "#{'%02d' % self.fecha_hora_inicio.hour}:#{'%02d' % self.fecha_hora_inicio.min}"
    end
  end
  
  def get_datetime_fin
    if !self.fecha_hora_fin.nil?
      self.fecha_fin ||= self.fecha_hora_fin.to_date.to_s(:db)
      self.hora_fin  ||= "#{'%02d' % self.fecha_hora_fin.hour}:#{'%02d' % self.fecha_hora_fin.min}"
    end
  end
  
  def set_datetime_inicio
    self.fecha_hora_inicio = "#{self.fecha_inicio} #{self.hora_inicio}:00"
  end
  
  def set_datetime_fin
    self.fecha_hora_fin = "#{self.fecha_fin} #{self.hora_fin}:00"
  end
end
