class CreateCuadernoControlesRevisiones < ActiveRecord::Migration
  def change
    create_table :cuaderno_controles_revisiones do |t|
      t.integer :cuaderno_control_id
      t.integer :alumno_id
      t.integer :persona_vinculada_id
      t.binary :revisado
      t.datetime :fecha_hora_revision
      t.text :observaciones
      t.string :usuario

      t.timestamps
    end
  end
end
