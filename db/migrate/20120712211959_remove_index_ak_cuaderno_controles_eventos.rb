class RemoveIndexAkCuadernoControlesEventos < ActiveRecord::Migration
  def change
    remove_index(:cuaderno_controles_eventos, :name => "ak_cuaderno_controles_eventos")
  end
end
