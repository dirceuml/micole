class AlterUsuariosSeccionesUsuarioToUsuarioNom < ActiveRecord::Migration
  rename_column :usuarios_secciones, :usuario, :usuario_nom
end
