class AddColumnAniosAlumnosSeccionId < ActiveRecord::Migration
  def change
    add_column :anios_alumnos, :seccion_id, :integer, :null => false
    add_index :anios_alumnos, [:seccion_id], :name => "fk_aniosalumnos_secciones"
    
    execute "Alter Table \"anios_alumnos\" Add Constraint fk_aniosalumnos_secciones Foreign Key (seccion_id) References \"secciones\"";

  end
end
