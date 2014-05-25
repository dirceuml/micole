class AddColumnColegiosNotificarTardanza < ActiveRecord::Migration
  def change
    add_column :colegios, :notificar_tardanza, :integer, :default => 0, :null => false
  end
end
