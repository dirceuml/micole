class Asistencia < ActiveRecord::Base
  belongs_to :anio_alumno   # estaba con alumno. modificado el 26/08/2012
  belongs_to :persona_vinculada
  
#  belongs_to :alumno, :through => :anios_alumnos   # se ha agregado el 26/08/2012
  
  scope :por_seccion_fecha, lambda { |seccion,fecha| joins(:anio_alumno).where("seccion_id = ? and to_char(fecha_hora, 'dd/mm/yyyy') = ?", seccion, fecha.strftime('%d/%m/%Y'))}
  
  def fecha
    fecha_hora.strftime('%d/%m/%Y')
  end
  
  def hora
    fecha_hora.strftime('%X')
  end
end
