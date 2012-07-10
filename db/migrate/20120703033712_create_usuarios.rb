class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.integer :colegio_id, :null => false
      t.string :usuario, :null => false
      t.string :nombre, :null => false
      t.string :clave, :null => false
      t.integer :perfil_id, :null => false
      t.integer :persona_vinculada_id
      t.string :correo

      t.timestamps
    end
  end
end
