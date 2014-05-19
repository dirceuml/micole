class Usuario < ActiveRecord::Base
#  attr_accessible :usuario, :clave, :clave_confirmation
  
  attr_accessor :clave, :clave_actual
  before_save :encrypt_password
  
  belongs_to :persona_vinculada
  belongs_to :alumno
  belongs_to :colegio
  belongs_to :perfil
  
  has_many :usuarios_secciones
  has_many :secciones, :through => :usuarios_secciones
  
  validates :usuario, :nombre, :perfil_id, :presence => { :message => ": El campo no puede estar vacio" }
  validates :clave, :confirmation => { :message => ": No ha confirmado correctamente la clave" }
  validates :clave, :presence => { :message => ": El campo no puede estar vacio" }, :on => :create
  validates :usuario, :uniqueness => { :message => "El usuario ya esta registrado" }
  #validates :usuario, :uniqueness => { :scope => :colegio_id, :message => "El usuario ya esta registrado" }  
  validate :clave_actual_ok, on: :update
  validate :clave_diferente, on: :update
  
  #validates :alcance_colegio, :presence => {:if => :perfil_id == 3, :message => ": Para este perfil seleccione el nivel de acceso" } 
  validate :if => "perfil_id == 2" do |a|   # Padre
    if a.persona_vinculada_id.nil?
      errors[:base] << "Seleccione la persona vinculada al usuario"
    end
  end
  
  validate :if => "perfil_id == 4" do |a|   # Alumno
    if a.alumno_id.nil?
      errors[:base] << "Seleccione al alumno vinculado al usuario"
    end
  end
  
  validate :if => "perfil_id == 3" do |a|   # Personal administrativo
    if a.alcance_colegio.nil?
      errors[:base] << "Seleccione el nivel de acceso para este perfil de usuario"
    end
  end
  
  scope :por_colegio, lambda { |colegio| where("colegio_id = ?", colegio) }
  scope :pendientenotificar, lambda { |colegio| self.por_colegio(colegio).where("notificado = 0", 0) }
  
  def self.authenticate(usuario, password)
    user = find_by_usuario(usuario)
    
    if user && user.clave_hash == BCrypt::Engine.hash_secret(password, user.clave_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if clave.present?
      self.clave_salt = BCrypt::Engine.generate_salt
      self.clave_hash = BCrypt::Engine.hash_secret(clave, clave_salt)
      
      self.fecha_clave = Time.now
    end
  end
  
  def clave_actual_ok
    if clave_actual.present?
      user = Usuario.authenticate(usuario, clave_actual)

      if !user
        errors.add(:clave_actual, "La clave actual no es correcta.")
      end
    end
  end
  
  def clave_diferente
    if clave_actual.present?
      if clave_actual == clave then
        errors.add(:clave, "La nueva clave debe ser diferente a la actual.")
      end
    end
  end

end
