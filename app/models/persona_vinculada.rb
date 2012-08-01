class PersonaVinculada < ActiveRecord::Base
  has_many :asistencias
  has_many :alumnos_personas_vinculadas
  has_many :alumnos, :through => :alumnos_personas_vinculadas
  has_many :cuadernos_controles_revisiones
  has_many :autorizaciones
  #has_one :usuario
  
  validates :tipo_documento, :numero_documento, :nombres, :apellido_paterno, :usuario, :presence => true
  validates :numero_documento, :uniqueness => { :scope => :tipo_documento, :message => "El documento ya esta registrado" }
  
  def apellidos_nombres
    apellido_paterno + " " + apellido_materno + " " + nombres
  end
  
  scope :logueado, lambda { |usuario| joins(:usuario).where("usuarios.usuario = ?", usuario) }
  scope :revisores_de, lambda { |alumno| joins(:alumnos_personas_vinculadas).where("revisa_control = 1 and alumno_id = ?", alumno)}
  scope :padres_de, lambda { |alumno| joins(:alumnos_personas_vinculadas).where("apoderado = 1 and alumno_id = ?", alumno)}

  def self.cargar(upload)
       directory = "public/images/"
    path = File.join(directory, "prueba")
    File.open(path, "wb") { |f| f.write(upload['datafile'].read)}
    render :text => "Fichero cargado con exito"
  end
end
