class CreateTiposNotas < ActiveRecord::Migration
  def change
    create_table :tipos_notas do |t|
      t.integer :anio_escolar_id
      t.string :descripcion
      t.string :usuario

      t.timestamps
    end
  end
end
