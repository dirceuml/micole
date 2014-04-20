class AnioAlumno < ActiveRecord::Base
  belongs_to :anio_escolar
  belongs_to :alumno
  belongs_to :seccion
  has_many :personas_vinculadas, :through => :alumno
  
  has_many :asistencias
#  has_many :personas_vinculadas
  
  validates :anio_escolar_id, :alumno_id, :usuario, :seccion_id, :presence => { :message => ": El campo no puede estar vacio" }
  validates :alumno_id, :uniqueness => {:scope => :anio_escolar_id, :message => ": Este alumno esta matriculado. Verifique" }
  
  # se ha modificado inasistencia_fecha: se ha retirado "tipo_movimiento = 2" del where a la tabla asistencias. tambien se está considerando a los años activos de todos los colegios.
  scope :inasistencia_fecha, lambda { |fecha| joins(:anio_escolar).where("anios_escolares.activo = 1 and anios_alumnos.id not in (Select anio_alumno_id from asistencias where to_char(fecha_hora, 'dd/mm/yyyy') = ?)", fecha.strftime('%d/%m/%Y'))}
  scope :pertenecen_a_seccion, lambda { |anioescolar, seccion| where("anios_alumnos.anio_escolar_id = ? and anios_alumnos.seccion_id = ?", anioescolar, seccion)}
  
  def enviar_inasistencia
    alumno.personas_vinculadas.where("apoderado = 1").find_each do |p|
      InasistenciaMailer.notificacion_inasistencia(alumno, p).deliver
    end
  end
end
