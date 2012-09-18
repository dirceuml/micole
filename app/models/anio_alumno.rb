class AnioAlumno < ActiveRecord::Base
  belongs_to :anio_escolar
  belongs_to :alumno
  belongs_to :seccion
  has_many :personas_vinculadas, :through => :alumno
  
  has_many :asistencias
#  has_many :personas_vinculadas
  
  validates :anio_escolar_id, :alumno_id, :usuario, :presence => true
end
