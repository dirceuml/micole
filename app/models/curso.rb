class Curso < ActiveRecord::Base
  has_many :curriculos
  has_many :grados, :through => :curriculos
  has_many :notas
  
  validates :descripcion, :abreviatura, :presence => { :message => ": El campo no puede estar vacio" }
  validates :descripcion, :uniqueness => { :message => "El nombre del curso ya esta registrado. Verifique" }
  validates :abreviatura, :uniqueness => { :message => "La abreviatura ya esta registrado. Verifique" }
end
