class Alumno < ActiveRecord::Base
  has_many :cuadernos_comtroles_eventos
  has_many :cuadernos_comtroles_revisiones
  has_many :autorizaciones
  has_many :alumnos_personas_vinculadas
  has_many :personas_vinculadas, :through => :alumnos_personas_vinculadas
  has_many :anios_alumnos
  has_many :anios_escolares, :through => :anios_alumnos
  
  validates :nombres, :apellido_paterno, :apellido_materno, :usuario, :presence => true
end
