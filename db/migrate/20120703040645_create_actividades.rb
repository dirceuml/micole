class CreateActividades < ActiveRecord::Migration
  def change
    create_table :actividades do |t|
      t.integer :anio_escolar_id
      t.integer :tipo_evento_id
      t.datetime :fecha_hora_inicio
      t.datetime :fecha_hora_fin
      t.integer :tipo_actividad
      t.string :nombre
      t.text :detalle
      t.binary :requiere_autorizacion
      t.date :limite_autorizacion
      t.date :inicio_notificacion
      t.date :fin_notificacion
      t.integer :frecuencia_dias_notificacion
      t.string :usuario

      t.timestamps
    end
  end
end
