class CreateAutorizaciones < ActiveRecord::Migration
  def change
    create_table :autorizaciones do |t|
      t.integer :actividad_id, :null => false
      t.integer :alumno_id, :null => false
      t.integer :persona_vinculada_id
      t.datetime :fecha_hora_autorizacion
      t.string :usuario, :null => false

      t.timestamps
    end
  end
end
