class AddColumnColegiosNotificarInasistencia < ActiveRecord::Migration
  def change
    add_column :colegios, :notificar_inasistencia, :integer, :default => 0, :null => false
  end
end
