class Alumno < ActiveRecord::Base
  has_many :cuadernos_controles_eventos
  has_many :cuadernos_controles_revisiones
  has_many :autorizaciones
  has_many :alumnos_personas_vinculadas
  has_many :personas_vinculadas, :through => :alumnos_personas_vinculadas
  has_many :anios_alumnos
  has_many :anios_escolares, :through => :anios_alumnos
  
  validates :nombres, :apellido_paterno, :apellido_materno, :usuario, :presence => true
  
  def apellidos_nombres
    apellido_paterno + " " + apellido_materno + " " + nombres
  end
  
  scope :hijos_de, lambda { |padre| joins(:alumno_persona_vinculada).where("apoderado = 1 and persona_vinculada_id = ?", padre) }
  scope :se_revisan_por, lambda { |padre| joins(:alumno_persona_vinculada).where("revisa_control = 1 and persona_vinculada_id = ?", padre) }
  scope :pertenecen_a_seccion, lambda { |seccion| joins(:anios_alumnos).where("seccion_id = ?", seccion)}
end
