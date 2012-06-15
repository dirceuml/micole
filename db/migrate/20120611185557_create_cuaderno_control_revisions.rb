class CreateCuadernoControlRevisions < ActiveRecord::Migration
  def change
    create_table :cuaderno_control_revisions do |t|
      t.integer :CodigoColegio
      t.date :Fecha
      t.string :Seccion
      t.integer :CodigoAlumno
      t.integer :Revisado
      t.text :Observaciones
      t.string :CodigoUsuario
      t.datetime :FechaUsuario

      t.timestamps
    end
  end
end
