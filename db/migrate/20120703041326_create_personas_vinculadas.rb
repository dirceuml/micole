class CreatePersonasVinculadas < ActiveRecord::Migration
  def change
    create_table :personas_vinculadas do |t|
      t.integer :tipo_documento
      t.string :numero_documento
      t.string :nombres
      t.string :apellido_paterno
      t.string :apellido_materno
      t.string :telefono_fijo
      t.string :telefono_movil
      t.string :correo
      t.string :foto
      t.string :usuario

      t.timestamps
    end
  end
end
