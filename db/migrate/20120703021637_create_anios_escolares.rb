class CreateAniosEscolares < ActiveRecord::Migration
  def change
    create_table :anios_escolares do |t|
      t.integer :colegio_id, :null => false
      t.integer :anio, :null => false
      t.date :inicio_clases
      t.date :fin_clases
      t.string :usuario, :null => false

      t.timestamps
    end
    
    add_index :anios_escolares, [:colegio_id, :anio], :name => "ak_aniosescolares", :unique => true
    add_index :anios_escolares, [:colegio_id], :name => "fk_aniosescolares_colegios"
    
    execute "Alter Table \"anios_escolares\" Add Constraint fk_aniosescolares_colegios Foreign Key (colegio_id) References \"colegios\"";
  end
end
