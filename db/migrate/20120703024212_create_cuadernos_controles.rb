class CreateCuadernosControles < ActiveRecord::Migration
  def change
    create_table :cuadernos_controles do |t|
      t.integer :seccion_id
      t.date :fecha
      t.integer :estado
      t.string :usuario

      t.timestamps
    end
  end
end
