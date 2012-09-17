class ActividadSeccion < ActiveRecord::Base
  belongs_to :actividad
  belongs_to :seccion
end
