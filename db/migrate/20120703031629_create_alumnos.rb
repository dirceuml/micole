class CreateAlumnos < ActiveRecord::Migration
  def change
    create_table :alumnos do |t|
      t.string :nombres
      t.string :apellido_paterno
      t.string :apellido_materno
      t.date :fecha_nacimiento
      t.string :telefono_fijo
      t.string :telefono_movil
      t.text :direccion
      t.string :correo
      t.string :foto
      t.string :usuario

      t.timestamps
    end
  end
end
