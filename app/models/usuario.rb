class Usuario < ActiveRecord::Base
  attr_accessible :usuario, :clave, :clave_confirmation
  
  belongs_to :persona_vinculada
  belongs_to :colegio
  belongs_to :perfil
  
  #validates :perfil_id, :usuario, :nombre, :clave, :presence => true
  validates :clave, :confirmation => true
  validates :usuario, :uniqueness => { :scope => :colegio_id, :message => "El usuario ya esta registrado" }
  
  def self.authenticate(usuario, password)
    user = find_by_usuario(usuario)
    #user = Usuario.find_by_usuario(usuario)
    if user && user.clave == password
      user
    else
      nil
    end
  end
end
