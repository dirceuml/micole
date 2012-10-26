class PerfilPermiso < ActiveRecord::Base
  belongs_to :perfil
  belongs_to :permiso
  
  validates :permiso_id, :perfil_id, :usuario, :presence => { :message => ": El campo no puede estar vacio" }
  validates :permiso_id, :uniqueness => { :scope => :perfil_id, :message => " ya esta vinculado con el perfil." }
  
  def detalle
    self.permiso.detalle
  end
end
