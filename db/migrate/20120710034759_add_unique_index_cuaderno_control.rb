class AddUniqueIndexCuadernoControl < ActiveRecord::Migration
  def change
    add_index :cuadernos_controles, [:seccion_id, :fecha], :name => "ui_cuadernocontrol_fechaseccion", :unique => true
    
  end
end
