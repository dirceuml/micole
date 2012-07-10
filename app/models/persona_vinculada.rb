class PersonaVinculada < ActiveRecord::Base
  has_many :asistencias
  has_many :alumnos_personas_vinculadas
  has_many :alumnos, :through => :alumnos_personas_vinculadas
  has_many :cuadernos_controles_revisiones
  has_many :autorizaciones
  has_one :usuario
  
  validates :tipo_documento, :numero_documento, :nombres, :apellido_paterno, :usuario, :presence => true
  validates :numero_documento, :uniqueness => { :scope => :tipo_documento, :message => "El documento ya está registrado" }
end
