class CreateNotas < ActiveRecord::Migration
  def change
    create_table :notas do |t|
      t.integer :anio_alumno_id, :null => false
      t.integer :curso_id, :null => false
      t.integer :tipo_nota_id, :null => false
      t.decimal :nota, :null => false
      t.text :observaciones
      t.string :usuario, :null => false

      t.timestamps
    end
  end
end
