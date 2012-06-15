class CreateCuadernoControlAlumnos < ActiveRecord::Migration
  def change
    create_table :cuaderno_control_alumnos do |t|
      t.integer :CodigoColegio
      t.date :Fecha
      t.string :Seccion
      t.integer :CodigoAlumno
      t.integer :TipoEvento
      t.text :Detalle
      t.string :CodigoUsuario
      t.datetime :FechaUsuario

      t.timestamps
    end
  end
end
