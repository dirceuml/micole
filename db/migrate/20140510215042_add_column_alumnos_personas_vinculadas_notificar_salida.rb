class AddColumnAlumnosPersonasVinculadasNotificarSalida < ActiveRecord::Migration
  def change
    add_column :alumnos_personas_vinculadas, :notificar_salida, :integer, :default => 0, :null => false
  end  
end
