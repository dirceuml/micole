class CreateCuadernoControlesEventos < ActiveRecord::Migration
  def change
    create_table :cuaderno_controles_eventos do |t|
      t.integer :cuaderno_control_id
      t.integer :tipo_evento_id
      t.integer :alumno_id
      t.text :descripcion
      t.string :usuario

      t.timestamps
    end
  end
end
