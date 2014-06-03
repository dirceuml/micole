class AddColumnColegiosRegistrarHoraTardanza < ActiveRecord::Migration
  def change
    add_column :colegios, :registrar_hora_tardanza, :integer, :default => 0, :null => false
  end
end
