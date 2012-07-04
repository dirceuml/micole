class CreatePerfiles < ActiveRecord::Migration
  def change
    create_table :perfiles do |t|
      t.string :descripcion

      t.timestamps
    end
  end
end
