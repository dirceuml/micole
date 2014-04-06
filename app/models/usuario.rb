class Usuario < ActiveRecord::Base
#  attr_accessible :usuario, :clave, :clave_confirmation
  
  attr_accessor :clave, :clave_actual
  before_save :encrypt_password
  
  belongs_to :persona_vinculada
  belongs_to :colegio
  belongs_to :perfil
  
  validates :usuario, :nombre, :perfil_id, :presence => { :message => ": El campo no puede estar vacio" }
  validates :clave, :confirmation => { :message => ": No ha confirmado correctamente la clave" }
  validates :clave, :presence => { :message => ": El campo no puede estar vacio" }, :on => :create
  validates :usuario, :uniqueness => { :scope => :colegio_id, :message => "El usuario ya esta registrado" }
  validate :clave_actual_ok, on: :update
  validate :clave_diferente, on: :update
  
  
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
