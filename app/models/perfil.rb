class Perfil < ActiveRecord::Base
  has_many :usuarios
  
  validates :descripcion, :presence => { :message => ": El campo no puede estar vacio" }
end
