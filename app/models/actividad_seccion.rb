class ActividadSeccion < ActiveRecord::Base
  belongs_to :actividad
  belongs_to :seccion
  
  def grado_seccion
    self.seccion.grado_seccion
  end
end
