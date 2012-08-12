class AlterUsuarioRenameClave < ActiveRecord::Migration
  def change
    rename_column :usuarios, :clave, :clave_hash
    add_column :usuarios, :clave_salt, :string, :default => :clave, :null => false
  end
end
