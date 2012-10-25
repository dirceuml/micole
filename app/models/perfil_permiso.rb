class PerfilPermiso < ActiveRecord::Base
  belongs_to :perfil
  belongs_to :permiso
end
