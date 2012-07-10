class CreateCuadernoControlesEventos < ActiveRecord::Migration
  def change
    create_table :cuaderno_controles_eventos do |t|
      t.integer :cuaderno_control_id, :null => false
      t.integer :tipo_evento_id, :null => false
      t.integer :alumno_id
      t.text :descripcion, :null => false
      t.string :usuario, :null => false

      t.timestamps
    end
  end
end
