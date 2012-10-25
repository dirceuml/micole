class Perfil < ActiveRecord::Base
  has_many :usuarios
  has_many :perfiles_permisos
  has_many :permisos, :through => :perfiles_permisos
  
  validates :descripcion, :presence => { :message => ": El campo no puede estar vacio" }
end
