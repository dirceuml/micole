class PersonaVinculada < ActiveRecord::Base
  has_many :asistencias
  has_many :alumnos_personas_vinculadas
  has_many :alumnos, :through => :alumnos_personas_vinculadas
  has_many :cuadernos_controles_revisiones
  has_many :autorizaciones
  has_one :usuario
  
  attr_accessor :origen
  
  #mount_uploader :foto, FotoUploader if :origen != "carga"
  #mount_uploader :foto, FotoUploader, {:ignore_integrity_errors => true, :ignore_processing_errors => true}
  mount_uploader :foto, FotoUploader
  
  validates :tipo_documento, :numero_documento, :nombres, :apellido_paterno, :correo, :user, :foto, :presence => { :message => ": El campo no puede estar vacio" }
  validates :numero_documento, :uniqueness => { :scope => :tipo_documento, :message => "El documento ya esta registrado" }
  validates :correo, :uniqueness => { :message => "El correo ya esta registrado" }
  
  def apellidos_nombres
    apellido_paterno + " " + apellido_materno + " " + nombres
  end
  
  scope :logueado, lambda { |usuario| joins(:usuario).where("usuarios.usuario = ?", usuario) }
  scope :revisores_de, lambda { |alumno| joins(:alumnos_personas_vinculadas).where("revisa_control = 1 and alumno_id = ?", alumno)}
  scope :receptores_notificacion_evento, lambda { |evento_id| joins(:alumnos_personas_vinculadas => :cuaderno_controles_eventos).where("alumnos_personas_vinculadas.apoderado = 1 and cuaderno_controles_eventos.id = ?", evento_id)}
  scope :anioescolar_colegio, lambda { |anioescolar| joins(:alumnos_personas_vinculadas => {:alumno => :anios_alumnos}).uniq.where("(apoderado = 1 or autoriza_actividad = 1 or revisa_control = 1) and anios_alumnos.anio_escolar_id = ? and anios_alumnos.estado = 1", anioescolar)}
  scope :vinculadas_a, lambda { |alumno| joins(:alumnos_personas_vinculadas).where("alumno_id = ?", alumno)}
  scope :no_vinculadas_a, lambda { |alumno| PersonaVinculada.find(PersonaVinculada.pluck(:id) - self.vinculadas_a(alumno).pluck(:persona_vinculada_id).map { |i| i.to_i }) }
  scope :padres_de, lambda { |alumno| self.vinculadas_a(alumno).where("apoderado = 1")}
end
