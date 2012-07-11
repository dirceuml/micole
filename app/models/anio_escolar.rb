class AnioEscolar < ActiveRecord::Base
  has_many :grados
  has_many :tipos_notas
  has_many :anios_alumnos
  has_many :alumnos, :through => :anios_alumnos
  has_many :actividades
  
  belongs_to :colegio
  
  validates :colegio_id, :anio, :usuario, :presence => true
  validates :anio, :uniqueness => {:scope => :colegio_id, :message => "Solamente se puede configurar un periodo por colegio"}
end
