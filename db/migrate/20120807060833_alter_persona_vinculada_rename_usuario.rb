class AlterPersonaVinculadaRenameUsuario < ActiveRecord::Migration
  def change
    rename_column :personas_vinculadas, :usuario, :user
  end
end
