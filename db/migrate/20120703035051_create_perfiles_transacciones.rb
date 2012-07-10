class CreatePerfilesTransacciones < ActiveRecord::Migration
  def change
    create_table :perfiles_transacciones do |t|
      t.integer :perfil_id, :null => false
      t.integer :transaccion_id, :null => false

      t.timestamps
    end
    
    add_index :perfiles_transacciones, [:perfil_id, :transaccion_id], :name => "ak_perfiles_transacciones", :unique => true
    add_index :perfiles_transacciones, [:perfil_id], :name => "fk_perfiltransaccion_perfil"
    add_index :perfiles_transacciones, [:transaccion_id], :name => "fk_perfiltransaccion_transac"
    
    execute "Alter Table \"perfiles_transacciones\" Add Constraint fk_perfiltransaccion_perfil Foreign Key (perfil_id) References \"perfiles\"";
    execute "Alter Table \"perfiles_transacciones\" Add Constraint fk_perfiltransaccion_transac Foreign Key (transaccion_id) References \"transacciones\"";
  end
end
