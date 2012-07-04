class CreateActividadesSecciones < ActiveRecord::Migration
  def change
    create_table :actividades_secciones do |t|
      t.integer :actividad_id
      t.integer :seccion_id
      t.string :usuario

      t.timestamps
    end
  end
end
