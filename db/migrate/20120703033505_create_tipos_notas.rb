class CreateTiposNotas < ActiveRecord::Migration
  def change
    create_table :tipos_notas do |t|
      t.integer :anio_escolar_id, :null => false
      t.string :descripcion, :null => false
      t.string :usuario, :null => false

      t.timestamps
    end
  end
end
