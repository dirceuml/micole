class CreateAlumnosPersonasVinculadas < ActiveRecord::Migration
  def change
    create_table :alumnos_personas_vinculadas do |t|
      t.integer :persona_vinculada_id, :null => false
      t.integer :alumno_id, :null => false
      t.integer :tipo_vinculo, :null => false
      t.integer :vigencia_vinculo, :null => false
      t.binary :apoderado, :null => false
      t.binary :autoriza_actividad, :null => false
      t.binary :revisa_control, :null => false
      t.date :inicio_vigencia, :null => false
      t.date :fin_vigencia, :null => false
      t.string :usuario, :null => false

      t.timestamps
    end
    
    add_index :alumnos_personas_vinculadas, [:persona_vinculada_id, :alumno_id], :name => "ak_alumnospersonasvinculadas", :unique => true
    add_index :alumnos_personas_vinculadas, [:persona_vinculada_id], :name => "fk_alumnospersonas_personas"
    add_index :alumnos_personas_vinculadas, [:alumno_id], :name => "fk_alumnospersonas_alumnos"
    
    execute "Alter Table \"alumnos_personas_vinculadas\" Add Constraint fk_alumnospersonas_personas Foreign Key (persona_vinculada_id) References \"personas_vinculadas\"";
    execute "Alter Table \"alumnos_personas_vinculadas\" Add Constraint fk_alumnospersonas_alumnos Foreign Key (alumno_id) References \"alumnos\"";
  end
end
