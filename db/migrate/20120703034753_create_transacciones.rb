class CreateTransacciones < ActiveRecord::Migration
  def change
    create_table :transacciones do |t|
      t.string :descripcion, :null => false
      t.integer :tipo, :null => false
      t.string :ruta, :null => false

      t.timestamps
    end
    
    add_index :transacciones, [:descripcion], :name => "ak_transacciones_descripcion", :unique => true
  end
end
