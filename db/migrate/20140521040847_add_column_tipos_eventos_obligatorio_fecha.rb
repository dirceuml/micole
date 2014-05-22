class AddColumnTiposEventosObligatorioFecha < ActiveRecord::Migration
  def change
    add_column :tipos_eventos, :obligatorio_fecha, :integer, :default => 0, :null => false
  end
end
