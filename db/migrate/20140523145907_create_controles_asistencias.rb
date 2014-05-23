class CreateControlesAsistencias < ActiveRecord::Migration
  def change
    create_table :controles_asistencias do |t|
      t.integer :anio_alumno_id, :null => false
      t.integer :tipo_asistencia, :null => false
      t.string :usuario, :null => false

      t.timestamps
    end
  end
end
