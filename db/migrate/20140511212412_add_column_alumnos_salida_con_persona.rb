class AddColumnAlumnosSalidaConPersona < ActiveRecord::Migration
  def change
    add_column :alumnos, :salida_con_persona, :integer, :default => 0, :null => false
  end
end
