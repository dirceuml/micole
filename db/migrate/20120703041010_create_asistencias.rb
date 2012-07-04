class CreateAsistencias < ActiveRecord::Migration
  def change
    create_table :asistencias do |t|
      t.integer :anio_alumno_id
      t.integer :persona_vinculada_id
      t.datetime :fecha_hora
      t.string :usuario

      t.timestamps
    end
  end
end
