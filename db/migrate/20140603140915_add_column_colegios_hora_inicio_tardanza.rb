class AddColumnColegiosHoraInicioTardanza < ActiveRecord::Migration
  def change
    add_column :colegios, :hora_inicio_tardanza, :timetz, :null => true
  end
end
