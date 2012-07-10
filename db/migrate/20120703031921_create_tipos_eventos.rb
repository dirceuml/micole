class CreateTiposEventos < ActiveRecord::Migration
  def change
    create_table :tipos_eventos do |t|
      t.integer :colegio_id, :null => false
      t.string :descripcion, :null => false
      t.binary :notificacion_inmediata, :null => false
      t.integer :alcance, :null => false
      t.binary :cuaderno_control, :null => false
      t.string :usuario, :null => false

      t.timestamps
    end
  end
end
