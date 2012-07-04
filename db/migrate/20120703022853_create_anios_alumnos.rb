class CreateAniosAlumnos < ActiveRecord::Migration
  def change
    create_table :anios_alumnos do |t|
      t.integer :anio_escolar_id
      t.integer :alumno_id
      t.string :usuario

      t.timestamps
    end
  end
end
