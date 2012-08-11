class Asistencia < ActiveRecord::Base
  belongs_to :alumno
  belongs_to :persona_vinculada
end
