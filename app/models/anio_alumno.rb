class AnioAlumno < ActiveRecord::Base
  belongs_to :anio_escolar
  belongs_to :alumno
  belongs_to :seccion
  
  validates :anio_escolar_id, :alumno_id, :usuario, :presence => true
end
