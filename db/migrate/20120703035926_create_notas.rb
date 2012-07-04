class CreateNotas < ActiveRecord::Migration
  def change
    create_table :notas do |t|
      t.integer :anio_alumno_id
      t.integer :curso_id
      t.integer :tipo_nota_id
      t.decimal :nota
      t.text :observaciones
      t.string :usuario

      t.timestamps
    end
  end
end
