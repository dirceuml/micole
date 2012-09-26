class ActividadSeccion < ActiveRecord::Base
  belongs_to :actividad
  belongs_to :seccion
  
  validates :seccion_id, :actividad_id, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  validates :seccion_id, :uniqueness => { :scope => :actividad_id, :message => " ya esta vinculada con la actividad." }
  
  def grado_seccion
    self.seccion.grado_seccion
  end
end
