class Colegio < ActiveRecord::Base
  has_many :anios_escolares
  has_many :tipos_eventos
  
  validate_presence_of :nombre, :usuario
  validate_uniqueness_of :nombre  
end
