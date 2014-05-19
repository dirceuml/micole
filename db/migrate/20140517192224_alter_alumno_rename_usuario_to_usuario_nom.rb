class AlterAlumnoRenameUsuarioToUsuarioNom < ActiveRecord::Migration
  rename_column :alumnos, :usuario, :usuario_nom
end
