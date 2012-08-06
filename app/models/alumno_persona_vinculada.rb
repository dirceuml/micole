class AlumnoPersonaVinculada < ActiveRecord::Base
  belongs_to :persona_vinculada
  belongs_to :alumno 
  
  validates :persona_vinculada_id, :alumno_id, :tipo_vinculo, :vigencia_vinculo, :apoderado, 
    :autoriza_actividad, :revisa_control, :inicio_vigencia, :usuario, :presence => true
  
  def apellidos_nombres
    self.persona_vinculada.apellidos_nombres
  end
  
  scope :por_documento, lambda { |tipo_documento, numero_documento| joins(:persona_vinculada).where("tipo_documento = ? and numero_documento = ?", tipo_documento, numero_documento)}  
end


