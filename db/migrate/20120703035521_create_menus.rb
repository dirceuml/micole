class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.integer :menu_id, :null => false
      t.integer :transaccion_id, :null => false
      t.integer :orden

      t.timestamps
    end
    
    add_index :menus, [:menu_id, :transaccion_id], :name => "ak_menus", :unique => true
    add_index :menus, [:menu_id], :name => "fk_menus_transaccionesmenu"
    add_index :menus, [:transaccion_id], :name => "fk_menus_transacciones"
    
    execute "Alter Table \"menus\" Add Constraint fk_menus_transaccionesmenu Foreign Key (menu_id) References \"transacciones\"";
    execute "Alter Table \"menus\" Add Constraint fk_menus_transacciones Foreign Key (transaccion_id) References \"transacciones\"";
  end
end
