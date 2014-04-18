class Nota < ActiveRecord::Base
  belongs_to :curso
  belongs_to :tipo_nota
  belongs_to :anio_alumno
  
  has_one :alumno, :through => :anio_alumno
  
  validates :nota, :presence => true, :numericality => true
  
  scope :por_dni, lambda { |dni| joins(:alumno).where("dni = ?", dni)}  
end
