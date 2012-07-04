class CreateAutorizaciones < ActiveRecord::Migration
  def change
    create_table :autorizaciones do |t|
      t.integer :actividad_id
      t.integer :alumno_id
      t.integer :persona_vinculada_id
      t.datetime :fecha_hora_autorizacion
      t.string :usuario

      t.timestamps
    end
  end
end
