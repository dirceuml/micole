class CreateActividadesSecciones < ActiveRecord::Migration
  def change
    create_table :actividades_secciones do |t|
      t.integer :actividad_id, :null => false
      t.integer :seccion_id, :null => false
      t.string :usuario, :null => false

      t.timestamps
    end
    
    add_index :actividades_secciones, [:actividad_id, :seccion_id], :name => "ak_actividades_secciones", :unique => true
    add_index :actividades_secciones, [:actividad_id], :name => "fk_activsecciones_actividades"
    add_index :actividades_secciones, [:seccion_id], :name => "fk_activsecciones_secciones"
    
    execute "Alter Table \"actividades_secciones\" Add Constraint fk_activsecciones_actividades Foreign Key (actividad_id) References \"actividades\"";
    execute "Alter Table \"actividades_secciones\" Add Constraint fk_activsecciones_secciones Foreign Key (seccion_id) References \"secciones\"";
  end
end
