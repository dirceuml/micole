class Asistencia < ActiveRecord::Base
  belongs_to :anio_alumno
  belongs_to :persona_vinculada
  # belongs_to :anio_alumno estaba con alumno. modificado el 26/08/2012
  
  scope :por_seccion_fecha, lambda { |seccion,fecha| joins(:anio_alumno).where("anio_escolar_id = 1 and seccion_id = ? and to_char(fecha_hora, 'dd/mm/yyyy') = ?", seccion, fecha.strftime('%d/%m/%Y'))}
  scope :salida, where(:tipo_movimiento => 2)
  scope :por_seccion_rango_fechas, lambda { |seccion,fechaI,fechaF| joins(:anio_alumno).where("anio_escolar_id = 1 and seccion_id = ? and to_char(fecha_hora, 'yyyymmdd') >= ? and to_char(fecha_hora, 'yyyymmdd') <= ?", seccion, fechaI.strftime('%Y%m%d'), fechaF.strftime('%Y%m%d'))}
  scope :por_alumno_fecha, lambda { |alumno,fecha| joins(:anio_alumno).where("anio_escolar_id = 1 and alumno_id = ? and to_char(fecha_hora, 'dd/mm/yyyy') = ?", alumno, fecha.strftime('%d/%m/%Y'))}
  
  
  def fecha
    fecha_hora.strftime('%d/%m/%Y')
  end
  
  def hora
    fecha_hora.strftime('%H:%M')
  end
  
  
end
