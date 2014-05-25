class AnioAlumno < ActiveRecord::Base
  belongs_to :anio_escolar
  belongs_to :alumno
  belongs_to :seccion
  has_many :personas_vinculadas, :through => :alumno
  
  has_many :asistencias
  has_many :controles_asistencias
#  has_many :personas_vinculadas
  
  validates :anio_escolar_id, :alumno_id, :usuario, :seccion_id, :presence => { :message => ": El campo no puede estar vacio" }
  validates :alumno_id, :uniqueness => {:scope => :anio_escolar_id, :message => ": Este alumno esta matriculado. Verifique" }
  
  # se ha modificado inasistencia_fecha: se ha retirado "tipo_movimiento = 2" del where a la tabla asistencias. tambien se está considerando a los años activos de todos los colegios.
  scope :inasistencia_fecha, lambda { |fecha| joins(:anio_escolar).where("anios_escolares.activo = 1 and anios_alumnos.estado = 1 and anios_alumnos.id not in (Select anio_alumno_id from asistencias where to_char(fecha_hora::timestamp at time zone 'UTC-5', 'yyyymmdd') = ?)", fecha.strftime('%Y%m%d'))}
  scope :pertenecen_a_seccion, lambda { |anioescolar, seccion| where("anios_alumnos.anio_escolar_id = ? and anios_alumnos.estado = 1 and anios_alumnos.seccion_id = ?", anioescolar, seccion)}
  scope :asistencia_fecha_notificarinasistencia, lambda { |fecha, notificarinasistencia| joins(:anio_escolar => :colegio).where("anios_escolares.activo = 1 and colegios.notificar_inasistencia = ? and anios_alumnos.estado = 1 and anios_alumnos.id in (Select anio_alumno_id from asistencias where to_char(fecha_hora::timestamp at time zone 'UTC-5', 'yyyymmdd') = ?)", notificarinasistencia, fecha.strftime('%Y%m%d'))}
  scope :inasistencia_anio_escolar_seccion_fecha, lambda { |anioescolar, seccion, fecha| where("anio_escolar_id = ? and seccion_id = ? and estado = 1 and id not in (Select anio_alumno_id from asistencias where to_char(fecha_hora::timestamp at time zone 'UTC-5', 'yyyymmdd') = ?)", anioescolar, seccion, fecha.strftime('%Y%m%d'))}
  
  # procedimiento desactivado 25/05/2014, porque se está enviando notificacion al momento de registrar las inasistencias.
  def enviar_inasistencia(horanotificacion)
    alumno.personas_vinculadas.where("apoderado = 1").find_each do |p|
      InasistenciaMailer.notificacion_inasistencia(alumno, p, horanotificacion).deliver
    end
  end
end
