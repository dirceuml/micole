class Usuario < ActiveRecord::Base
#  attr_accessible :usuario, :clave, :clave_confirmation
  
  attr_accessor :clave
  before_save :encrypt_password
  
  belongs_to :persona_vinculada
  belongs_to :colegio
  belongs_to :perfil
  
  validates :perfil_id, :usuario, :nombre, :presence => true
  validates :clave, :confirmation => true
  validates :clave, :presence => true, :on => :create
  validates :usuario, :uniqueness => { :scope => :colegio_id, :message => "El usuario ya esta registrado" }
  
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
    end
  end
end
