class CreateTiposEventos < ActiveRecord::Migration
  def change
    create_table :tipos_eventos do |t|
      t.integer :colegio_id
      t.string :descripcion
      t.binary :notificacion_inmediata
      t.integer :alcance
      t.binary :cuaderno_control
      t.string :usuario

      t.timestamps
    end
  end
end
