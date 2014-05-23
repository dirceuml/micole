class ControlAsistencia < ActiveRecord::Base
  belongs_to :anio_alumno
  belongs_to :alumno, :through => :anio_alumno
  attr_accessible :anio_alumno_id, :tipo_asistencia, :usuario
  
  validates :anio_alumno_id, :tipo_asistencia, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
end
