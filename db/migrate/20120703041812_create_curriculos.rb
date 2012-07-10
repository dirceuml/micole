class CreateCurriculos < ActiveRecord::Migration
  def change
    create_table :curriculos do |t|
      t.integer :grado_id, :null => false
      t.integer :curso_id, :null => false

      t.timestamps
    end
    
    add_index :curriculos, [:grado_id, :curso_id], :name => "ak_curriculos", :unique => true
    add_index :curriculos, [:grado_id], :name => "fk_curriculos_grados"
    add_index :curriculos, [:curso_id], :name => "fk_curriculos_cursos"
    
    execute "Alter Table \"curriculos\" Add Constraint fk_curriculos_grados Foreign Key (grado_id) References \"grados\"";
    execute "Alter Table \"curriculos\" Add Constraint fk_curriculos_cursos Foreign Key (curso_id) References \"cursos\"";
  end
end
