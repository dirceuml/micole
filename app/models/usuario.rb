class Usuario < ActiveRecord::Base
  belongs_to :persona_vinculada
  belongs_to :colegio
  belongs_to :perfil
  
  validates :perfil_id, :persona_vinculada_id, :usuario, :nombre, :clave, :presence => true
  validates :clave, :confirmation => true
  validates :usuario, :uniqueness => { :scope => :colegio_id, :message => "El usuario ya está registrado" }
end
