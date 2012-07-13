class AlterColumnsAlumnosPersonas < ActiveRecord::Migration
  def change
    remove_column :alumnos_personas_vinculadas, :apoderado
    remove_column :alumnos_personas_vinculadas, :autoriza_actividad
    remove_column :alumnos_personas_vinculadas, :revisa_control
    add_column :alumnos_personas_vinculadas, :apoderado, :integer, :default => 0, :null => false
    add_column :alumnos_personas_vinculadas, :autoriza_actividad, :integer, :default => 0, :null => false
    add_column :alumnos_personas_vinculadas, :revisa_control, :integer, :default => 0, :null => false
  end
end
