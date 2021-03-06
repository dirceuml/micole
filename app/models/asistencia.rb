class Asistencia < ActiveRecord::Base
  belongs_to :anio_alumno
  belongs_to :persona_vinculada
  # belongs_to :anio_alumno estaba con alumno. modificado el 26/08/2012
  
  scope :por_seccion_fecha, lambda { |anioescolar, seccion, fecha| joins(:anio_alumno).where("anio_escolar_id = ? and seccion_id = ? and to_char(fecha_hora::timestamp at time zone 'UTC-5', 'yyyymmdd') = ?", anioescolar, seccion, fecha.strftime('%Y%m%d'))}
  scope :salida, where(:tipo_movimiento => 2)
  scope :por_seccion_rango_fechas, lambda { |anioescolar, seccion, fechaI, fechaF| joins(:anio_alumno).where("anio_escolar_id = ? and seccion_id = ? and to_char(fecha_hora::timestamp at time zone 'UTC-5', 'yyyymmdd') >= ? and to_char(fecha_hora::timestamp at time zone 'UTC-5', 'yyyymmdd') <= ?", anioescolar, seccion, fechaI.strftime('%Y%m%d'), fechaF.strftime('%Y%m%d'))}
  scope :por_alumno_fecha, lambda { |anioescolar, alumno, fecha| joins(:anio_alumno).where("anio_escolar_id = ? and alumno_id = ? and to_char(fecha_hora::timestamp at time zone 'UTC-5', 'yyyymmdd') = ?", anioescolar, alumno, fecha.strftime('%Y%m%d'))}
  scope :por_alumno_rango_fechas, lambda { |anioescolar, alumno, fechaI, fechaF| joins(:anio_alumno).where("anio_escolar_id = ? and alumno_id = ? and to_char(fecha_hora::timestamp at time zone 'UTC-5', 'yyyymmdd') >= ? and to_char(fecha_hora::timestamp at time zone 'UTC-5', 'yyyymmdd') <= ?", anioescolar, alumno, fechaI.strftime('%Y%m%d'), fechaF.strftime('%Y%m%d'))}
  
  def fecha
    fecha_hora.strftime('%d/%m/%Y')
  end
  
  def hora
    fecha_hora.strftime('%H:%M')
  end
  
  
end
