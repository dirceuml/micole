class CreateCuadernoControls < ActiveRecord::Migration
  def change
    create_table :cuaderno_controls do |t|
      t.integer :CodigoColegio
      t.date :Fecha
      t.string :Seccion
      t.integer :Estado
      t.string :CodigoUsuario
      t.datetime :FechaUsuario

      t.timestamps
    end
  end
end
