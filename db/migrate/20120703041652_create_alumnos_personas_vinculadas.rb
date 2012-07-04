class CreateAlumnosPersonasVinculadas < ActiveRecord::Migration
  def change
    create_table :alumnos_personas_vinculadas do |t|
      t.integer :persona_vinculada_id
      t.integer :alumno_id
      t.integer :tipo_vinculo
      t.integer :vigencia_vinculo
      t.binary :apoderado
      t.binary :autoriza_actividad
      t.binary :revisa_control
      t.date :inicio_vigencia
      t.date :fin_vigencia
      t.string :usuario

      t.timestamps
    end
  end
end
