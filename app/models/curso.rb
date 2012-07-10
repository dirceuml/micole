class Curso < ActiveRecord::Base
  has_many :curriculos
  has_many :grados, :through => :curriculos
  has_many :notas
end
