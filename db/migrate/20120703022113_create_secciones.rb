class CreateSecciones < ActiveRecord::Migration
  def change
    create_table :secciones do |t|
      t.integer :grado_id, :null => false
      t.string :seccion, :null => false
      t.string :usuario, :null => false

      t.timestamps
    end
    
    add_index :secciones, [:grado_id, :seccion], :name => "ak_secciones", :unique => true
    add_index :secciones, [:grado_id], :name => "fk_secciones_grados"
    
    execute "Alter Table \"secciones\" Add Constraint fk_secciones_grados Foreign Key (grado_id) References \"grados\"";

  end
end
