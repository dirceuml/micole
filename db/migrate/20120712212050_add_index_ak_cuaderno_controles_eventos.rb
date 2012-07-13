class AddIndexAkCuadernoControlesEventos < ActiveRecord::Migration
  def change
    add_index :cuaderno_controles_eventos, [:cuaderno_control_id, :tipo_evento_id], :name => "idx_cuadcontrolevento_evento"
  end
end
