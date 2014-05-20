class AlumnoPersonaVinculada < ActiveRecord::Base
  belongs_to :persona_vinculada
  belongs_to :alumno 
  has_many :cuaderno_controles_eventos, :through => :alumno
  
  accepts_nested_attributes_for :persona_vinculada, :allow_destroy => true  
  attr_accessible :persona_vinculada_attributes
  attr_accessible :persona_vinculada_id, :alumno_id, :tipo_vinculo, :vigencia_vinculo, :inicio_vigencia, :fin_vigencia, :apoderado, :autoriza_actividad, :revisa_control, :usuario
  
  #:persona_vinculada_id, 
  validates :tipo_vinculo, :vigencia_vinculo, :apoderado, 
    :autoriza_actividad, :revisa_control, :inicio_vigencia, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  validates :fin_vigencia, :presence => true, :if => lambda { |alumno_persona_vinculada| alumno_persona_vinculada.vigencia_vinculo == 1 }
  validates :alumno_id, :uniqueness => { :scope => :persona_vinculada_id, :message => " ya esta vinculado con la persona." }
  
  def apellidos_nombres
    self.persona_vinculada.apellidos_nombres
  end
  
  scope :por_documento, lambda { |tipo_documento, numero_documento| joins(:persona_vinculada).where("tipo_documento = ? and numero_documento = ?", tipo_documento, numero_documento)}
  scope :notificar_ingreso, lambda { |alumno| where("alumno_id = ? and notificar_ingreso = 1", alumno)}
  scope :notificar_salida, lambda { |alumno| where("alumno_id = ? and notificar_salida = 1", alumno)}
  
end


