class CreateAniosAlumnos < ActiveRecord::Migration
  def change
    create_table :anios_alumnos do |t|
      t.integer :anio_escolar_id, :null => false
      t.integer :alumno_id, :null => false
      t.string :usuario, :null => false

      t.timestamps
    end
    
    add_index :anios_alumnos, [:anio_escolar_id, :alumno_id], :name => "ak_anios_alumnos", :unique => true
    add_index :anios_alumnos, [:anio_escolar_id], :name => "fk_aniosalumnos_anioescolar"
    add_index :anios_alumnos, [:alumno_id], :name => "fk_aniosalumnos_alumno"
    
    execute "Alter Table \"anios_alumnos\" Add Constraint fk_aniosalumnos_anioescolar Foreign Key (anio_escolar_id) References \"anios_escolares\"";

  end
end
