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
  
  validates :tipo_documento, :numero_documento, :nombres, :apellido_paterno, :user, :foto, :presence => { :message => ": El campo no puede estar vacio" }
  validates :numero_documento, :uniqueness => { :scope => :tipo_documento, :message => "El documento ya esta registrado" }
  
  def apellidos_nombres
    apellido_paterno + " " + apellido_materno + " " + nombres
  end
  
  scope :logueado, lambda { |usuario| joins(:usuario).where("usuarios.usuario = ?", usuario) }
  scope :revisores_de, lambda { |alumno| joins(:alumnos_personas_vinculadas).where("revisa_control = 1 and alumno_id = ?", alumno)}
  scope :padres_de, lambda { |alumno| joins(:alumnos_personas_vinculadas).where("apoderado = 1 and alumno_id = ?", alumno)}  
  scope :receptores_notificacion_evento, lambda { |evento_id| joins(:alumnos_personas_vinculadas => :cuaderno_controles_eventos).where("alumnos_personas_vinculadas.apoderado = 1 and cuaderno_controles_eventos.id = ?", evento_id)}
end
