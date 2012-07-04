class CreateTransacciones < ActiveRecord::Migration
  def change
    create_table :transacciones do |t|
      t.string :descripcion
      t.integer :tipo
      t.string :ruta

      t.timestamps
    end
  end
end
