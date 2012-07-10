class Nota < ActiveRecord::Base
  belongs_to :curso
  belongs_to :tipo_nota
  belongs_to :anio_alumno
  
  validates :nota, :presence => true, :numericality => true
end
