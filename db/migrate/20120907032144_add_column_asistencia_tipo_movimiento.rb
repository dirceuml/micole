class AddColumnAsistenciaTipoMovimiento < ActiveRecord::Migration
  def change
    add_column :asistencias, :tipo_movimiento, :integer, :default => 2, :null => false
  end
end
