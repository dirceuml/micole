class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.integer :perfil_id
      t.integer :persona_vinculada_id
      t.string :usuario
      t.string :nombre
      t.string :clave

      t.timestamps
    end
  end
end
