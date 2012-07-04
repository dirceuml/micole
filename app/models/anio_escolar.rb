class AnioEscolar < ActiveRecord::Base
  has_many :grados
  has_many :tipos_notas
  has_many :anios_alumnos
  has_many :actividades
  
  belongs_to :colegio
  
  validate_presence_of :colegio_id, :anio, :usuario
  validate_uniqueness_of [:colegio_id, :anio]  
end
