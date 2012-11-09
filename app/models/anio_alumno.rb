class AnioAlumno < ActiveRecord::Base
  belongs_to :anio_escolar
  belongs_to :alumno
  belongs_to :seccion
  has_many :personas_vinculadas, :through => :alumno
  
  has_many :asistencias
#  has_many :personas_vinculadas
  
  validates :anio_escolar_id, :alumno_id, :usuario, :presence => true
  
  scope :inasistencia_fecha, lambda { |fecha| where("anio_escolar_id = 1 and id not in (Select anio_alumno_id from asistencias where tipo_movimiento = 2 and to_char(fecha_hora, 'dd/mm/yyyy') = ?)", fecha.strftime('%d/%m/%Y'))}
  
  def enviar_inasistencia
    alumno.personas_vinculadas.where("apoderado = 1").find_each do |p|
      InasistenciaMailer.notificacion_inasistencia(alumno, p).deliver
    end
  end
end
