class CreateCuadernoControlesRevisiones < ActiveRecord::Migration
  def change
    create_table :cuaderno_controles_revisiones do |t|
      t.integer :cuaderno_control_id, :null => false
      t.integer :alumno_id, :null => false
      t.integer :persona_vinculada_id, :null => false
      t.binary :revisado, :null => false
      t.datetime :fecha_hora_revision
      t.text :observaciones
      t.string :usuario, :null => false

      t.timestamps
    end
  end
end
