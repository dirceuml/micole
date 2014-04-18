class Alumno < ActiveRecord::Base
  has_many :cuaderno_controles_eventos
  has_many :cuadernos_controles_revisiones
  has_many :autorizaciones
  has_many :alumnos_personas_vinculadas
  has_many :personas_vinculadas, :through => :alumnos_personas_vinculadas
  has_many :anios_alumnos
  has_many :anios_escolares, :through => :anios_alumnos
  
  has_many :asistencias, :through => :anios_alumnos
  
  validates :nombres, :apellido_paterno, :apellido_materno, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  validates :dni, :presence => { :message => ": El campo no puede estar vacio" }, :uniqueness => { :message => ": Este DNI esta registrado. Verifique" }, :format => { :with => /\A[+-]?\d+\Z/, :message => ": Solo se permiten numeros"}
  
  def apellidos_nombres
    apellido_paterno + " " + apellido_materno + " " + nombres
  end
  
  def salida_registrada (alumno_id, fecha)
    Alumno.joins(:anios_alumnos => :asistencias).where("to_char(fecha_hora, 'dd/mm/yyyy') = ? and alumnos.id = ?", fecha.strftime('%d/%m/%Y'), alumno_id).count
  end
  
  def find_asistencia_by_alumno_id_and_fecha (alumno_id, fecha)
    Asistencia.find(:all, :conditions => ["to_char(fecha_hora, 'dd/mm/yyyy') = '#{fecha}' and anio_alumno_id = #{alumno_id}"]).first
    # creo que se debe revisar la parte de la condicion: anio_alumno_id = #{alumno_id
  end
  
  scope :hijos_de, lambda { |padre| joins(:alumno_persona_vinculada).where("apoderado = 1 and persona_vinculada_id = ?", padre) }
  scope :se_revisan_por, lambda { |padre| joins(:alumno_persona_vinculada).where("revisa_control = 1 and persona_vinculada_id = ?", padre) }
  scope :pertenecen_a_seccion, lambda { |seccion| joins(:anios_alumnos).where("anios_alumnos.seccion_id = ?", seccion)}
end
