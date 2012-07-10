class CreateListasValores < ActiveRecord::Migration
  def change
    create_table :listas_valores do |t|
      t.integer :tabla, :null => false
      t.integer :item, :null => false
      t.string :descripcion, :null => false
      t.string :abreviatura

      t.timestamps
    end
    
    add_index :listas_valores, [:tabla, :item], :name => "ak_listas_valores", :unique => true
  end
end
