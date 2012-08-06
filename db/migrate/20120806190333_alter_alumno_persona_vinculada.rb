class AlterAlumnoPersonaVinculada < ActiveRecord::Migration
  def change
    remove_column :alumnos_personas_vinculadas, :fin_vigencia
    add_column :alumnos_personas_vinculadas, :fin_vigencia, :date, :null => true    
  end
end
