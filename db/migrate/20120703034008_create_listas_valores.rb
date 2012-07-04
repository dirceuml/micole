class CreateListasValores < ActiveRecord::Migration
  def change
    create_table :listas_valores do |t|
      t.integer :tabla
      t.integer :item
      t.string :descripcion
      t.string :abreviatura

      t.timestamps
    end
  end
end
