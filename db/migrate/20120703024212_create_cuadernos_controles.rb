class CreateCuadernosControles < ActiveRecord::Migration
  def change
    create_table :cuadernos_controles do |t|
      t.integer :seccion_id, :null => false
      t.date :fecha, :null => false
      t.integer :estado, :null => false
      t.string :usuario, :null => false

      t.timestamps
    end
    
    add_index :cuadernos_controles, [:seccion_id], :name => "fk_cuadernoscontroles_secciones"
    
    execute "Alter Table \"cuadernos_controles\" Add Constraint fk_cuadernoscontroles_secciones Foreign Key (seccion_id) References \"secciones\"";

  end
end
