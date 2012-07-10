class AlumnoPersonaVinculada < ActiveRecord::Base
  belongs_to :personas_vinculadas
  belongs_to :alumnos  
  
  validates :persona_vinculada_id, :alumno_id, :tipo_vinculo, :vigencia_vinculo, :apoderado, 
    :autoriza_actividad, :revisa_control, :inicio_vigencia, :usuario, :presence => true
end


