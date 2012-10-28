class CreatePerfilesPermisos < ActiveRecord::Migration
  def change
    create_table :perfiles_permisos do |t|
      t.integer :perfil_id, :null => false
      t.integer :permiso_id, :null => false

      t.timestamps
    end
    
    add_index :perfiles_permisos, [:perfil_id, :permiso_id], :name => "ak_perfiles_permisos", :unique => true
    add_index :perfiles_permisos, [:perfil_id], :name => "fk_perfilespermisos_perfiles"
    add_index :perfiles_permisos, [:permiso_id], :name => "fk_perfilespermisos_permisos"
    
    execute "Alter Table \"perfiles_permisos\" Add Constraint fk_perfilespermisos_perfiles Foreign Key (perfil_id) References \"perfiles\"";
    execute "Alter Table \"perfiles_permisos\" Add Constraint fk_perfilespermisos_permisos Foreign Key (permiso_id) References \"permisos\"";

  end
end
