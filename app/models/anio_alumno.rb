class AnioAlumno < ActiveRecord::Base
  belongs_to :anios_escolares
  belongs_to :alumnos
  
  validates :anio_escolar_id, :alumno_id, :usuario, :presence => true
end
