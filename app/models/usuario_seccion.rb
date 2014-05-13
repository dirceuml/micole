class UsuarioSeccion < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :seccion
  
  validates :seccion_id, :usuario_id, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  validates :seccion_id, :uniqueness => { :scope => :usuario_id, :message => " ya esta vinculada con el usuario." }
  
  def grado_seccion
    self.seccion.grado_seccion
  end
end
