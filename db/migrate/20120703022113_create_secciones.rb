class CreateSecciones < ActiveRecord::Migration
  def change
    create_table :secciones do |t|
      t.integer :grado_id
      t.string :seccion
      t.string :usuario

      t.timestamps
    end
  end
end
