class CreatePersonasVinculadas < ActiveRecord::Migration
  def change
    create_table :personas_vinculadas do |t|
      t.integer :tipo_documento, :null => false
      t.string :numero_documento, :null => false
      t.string :nombres, :null => false
      t.string :apellido_paterno, :null => false
      t.string :apellido_materno
      t.string :telefono_fijo
      t.string :telefono_movil
      t.string :correo
      t.string :foto
      t.string :usuario, :null => false

      t.timestamps
    end
    
    add_index :personas_vinculadas, [:tipo_documento, :numero_documento], :name => "ak_personas_vinculadas", :unique => true
  end
end
