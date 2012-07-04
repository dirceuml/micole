class CreateColegios < ActiveRecord::Migration
  def change
    create_table :colegios do |t|
      t.string :nombre, :null => false
      t.string :ruc
      t.text :direccion
      t.string :telefono
      t.string :correo
      t.string :logo
      t.string :director
      t.string :usuario, :null => false

      t.timestamps
    end
    
    add_index :colegios, [:nombre], :name => "ui_colegios_nombre", :unique => true
  end
end
