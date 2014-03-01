class Colegio < ActiveRecord::Base
  has_many :anios_escolares
  has_many :tipos_eventos
  
  validates :nombre, :presence => { :message => ": El campo no puede estar vacio" }, :uniqueness => true
end
