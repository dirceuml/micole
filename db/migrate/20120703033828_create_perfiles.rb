class CreatePerfiles < ActiveRecord::Migration
  def change
    create_table :perfiles do |t|
      t.string :descripcion, :null => false

      t.timestamps
    end
    
    add_index :perfiles, [:descripcion], :name => "ak_perfiles_descripcion", :unique => true
  end
end
