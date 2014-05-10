class AddColumnAlumnosPersonasVinculadasNotificarIngreso < ActiveRecord::Migration
  def change
    add_column :alumnos_personas_vinculadas, :notificar_ingreso, :integer, :default => 0, :null => false
  end
end
