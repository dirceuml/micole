class AddColumnCuadernoControlEventoFechaEvento < ActiveRecord::Migration
  def change
    add_column :cuaderno_controles_eventos, :fecha_evento, :date, :null => true
  end
end
