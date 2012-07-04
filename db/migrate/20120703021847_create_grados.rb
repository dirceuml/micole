class CreateGrados < ActiveRecord::Migration
  def change
    create_table :grados do |t|
      t.integer :anio_escolar_id
      t.integer :grado
      t.string :usuario

      t.timestamps
    end
    
    add_index :grados, [:anio_escolar_id, :grado], :name => "ak_grados", :unique => true
    add_index :grados, [:anio_escolar_id], :name => "fk_grados_aniosescolares"
    
    execute "Alter Table \"grados\" Add Constraint fk_grados_aniosescolares Foreign Key (anio_escolar_id) References \"anios_escolares\"";

  end
end
