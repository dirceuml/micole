class Alumno < ActiveRecord::Base
  #extend Validaciones
  
  has_many :cuaderno_controles_eventos
  has_many :cuadernos_controles_revisiones
  has_many :autorizaciones
  has_many :alumnos_personas_vinculadas
  has_many :personas_vinculadas, :through => :alumnos_personas_vinculadas
  has_many :anios_alumnos
  has_many :anios_escolares, :through => :anios_alumnos
  has_many :secciones, :through => :anios_alumnos
  has_many :asistencias, :through => :anios_alumnos
  has_one  :usuario
  
  attr_accessor :origen
  
  accepts_nested_attributes_for :alumnos_personas_vinculadas, :allow_destroy => true  
  attr_accessible :alumnos_personas_vinculadas_attributes
  attr_accessible :nombres, :apellido_paterno, :apellido_materno, :fecha_nacimiento, :dni, :telefono_fijo, :telefono_movil, :direccion, :correo, :salida_con_persona, :foto, :usuario_nom
  
  mount_uploader :foto, FotoUploader
  
  validates :nombres, :apellido_paterno, :apellido_materno, :usuario_nom, :presence => { :message => ": El campo no puede estar vacio" }
  validate :rango_fecha_nacimiento
  validates :dni, :presence => { :message => ": El campo no puede estar vacio" }, :uniqueness => { :message => ": Este DNI esta registrado. Verifique" }, :format => { :with => /\A[+-]?\d+\Z/, :message => ": Solo se permiten numeros"}
  validates :correo, :uniqueness => { :message => "El correo ya esta registrado" }
  validates :dni, :uniqueness => { :message => "El DNI ya esta registrado" }
  
  def apellidos_nombres
    apellido_paterno + " " + apellido_materno + " " + nombres
  end
  
  def nombres_apellido_paterno
    nombres+ "  "+ apellido_paterno
  end
  
  def seccion_id(anioescolar)
    anioalumno = AnioAlumno.find_by_anio_escolar_id_and_alumno_id(anioescolar, id)
    if !anioalumno.nil?
      secc = anioalumno.seccion
      secc.id
    else
      nil
    end
  end
  
  def grado_seccion(anioescolar)
    if !seccion_id(anioescolar).nil?
      secc = Seccion.find(seccion_id(anioescolar))
      secc.grado.grado.to_s + " " + secc.seccion + " " + ListaValor.find_by_tabla_and_item(9, secc.grado.nivel).descripcion
    else
      "SIN SECCION"
    end
  end
  
  def salida_registrada (alumno_id, fecha)
    Alumno.joins(:anios_alumnos => :asistencias).where("to_char(fecha_hora::timestamp at time zone 'UTC-5', 'yyyymmdd') = ? and alumnos.id = ? and tipo_movimiento = 2", fecha.strftime('%Y%m%d'), alumno_id).count
  end
  
  def find_asistencia_by_anio_escolar_id_and_alumno_id_and_fecha (anioescolar, alumno_id, fecha, movimiento)
    anioalumno_id = AnioAlumno.find_by_anio_escolar_id_and_alumno_id(anioescolar, alumno_id).id
    Asistencia.find(:all, :conditions => ["to_char(fecha_hora::timestamp at time zone 'UTC-5', 'yyyymmdd') = '#{fecha.strftime('%Y%m%d')}' and anio_alumno_id = #{anioalumno_id} and tipo_movimiento = #{movimiento}"]).first
  end
  
  def rango_fecha_nacimiento
    if fecha_nacimiento.present?
      if !fecha_nacimiento.between?(Date.parse(18.years.ago.to_s), Date.parse(4.years.ago.to_s)) then
        errors.add(:fecha_nacimiento, "La fecha de nacimiento esta fuera del rango permitido.")
      end
    end
  end
  
  #scope :por_colegio, lambda { |colegio| joins(:anios_escolares).where("anios_escolares.colegio_id = ?", colegio)}
  #scope :por_anio_colegio, lambda { |colegio, anio| self.por_colegio(colegio).joins(:anios_alumnos).where("anios_alumnos.anio_escolar_id = ?", anio)}
  scope :hijos_de, lambda { |padre| joins(:alumnos_personas_vinculadas).where("apoderado = 1 and persona_vinculada_id = ?", padre) }
  scope :se_revisan_por, lambda { |padre| joins(:alumnos_personas_vinculadas).where("revisa_control = 1 and persona_vinculada_id = ?", padre) }
  scope :pertenecen_a_seccion, lambda { |anioescolar, seccion| joins(:anios_alumnos).where("anios_alumnos.anio_escolar_id = ? and anios_alumnos.seccion_id = ? and anios_alumnos.estado = 1", anioescolar, seccion)}
  scope :por_anio_escolar, lambda { |anioescolar| joins(:anios_alumnos).where("anios_alumnos.anio_escolar_id = ? and anios_alumnos.estado = 1", anioescolar)}
  
end
