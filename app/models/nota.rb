class Nota < ActiveRecord::Base
  belongs_to :curso
  belongs_to :tipo_nota
  belongs_to :anio_alumno
  
  has_one :alumno, :through => :anio_alumno
  
  validates :nota, :presence => true, :numericality => true
  validates :fecha_nota, :presence => { :message => ": Debe especificar la fecha de la nota." }
  
  scope :por_dni, lambda { |dni| joins(:alumno).where("dni = ?", dni)}  
  scope :por_alumno_id, lambda { |id| joins(:alumno).where("alumno_id = ?", id)}  
  scope :por_padre, lambda { |padre| joins(:alumno => :alumnos_personas_vinculadas).where("revisa_control = 1 and alumnos_personas_vinculadas.persona_vinculada_id = ?", padre) }
end
