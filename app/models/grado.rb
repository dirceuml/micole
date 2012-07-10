class Grado < ActiveRecord::Base
  belongs_to :anio_escolar
  has_many :secciones
  has_many :curriculos
  has_many :cursos, :through => :curriculos
  
  validates :grado, :usuario, :presence => true
  validates :grado, :numericality => { :only_integer => true }
end
