class ControlAsistencia < ActiveRecord::Base
  belongs_to :anio_alumno
  #belongs_to :alumno, :through => :anio_alumno
  attr_accessible :anio_alumno_id, :tipo_asistencia, :usuario, :fecha
  
  validates :anio_alumno_id, :tipo_asistencia, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  
  scope :por_anio_escolar_seccion_rango_fechas, lambda { |anioescolar, seccion, fechaI, fechaF| joins(:anio_alumno).where("anio_escolar_id = ? and seccion_id = ? and anios_alumnos.estado = 1 and to_char(fecha, 'yyyymmdd') >= ? and to_char(fecha, 'yyyymmdd') <= ?", anioescolar, seccion, fechaI.strftime('%Y%m%d'), fechaF.strftime('%Y%m%d'))}
  
end
