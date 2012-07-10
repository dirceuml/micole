class Colegio < ActiveRecord::Base
  has_many :anios_escolares
  has_many :tipos_eventos
  
  validates :nombre, :presence => true, :uniqueness => true
end
