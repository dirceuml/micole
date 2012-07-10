class CreateAsistencias < ActiveRecord::Migration
  def change
    create_table :asistencias do |t|
      t.integer :anio_alumno_id, :null => false
      t.datetime :fecha_hora, :null => false
      t.integer :persona_vinculada_id
      t.string :usuario, :null => false

      t.timestamps
    end
  end
end
