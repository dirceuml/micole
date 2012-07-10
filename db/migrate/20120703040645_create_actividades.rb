class CreateActividades < ActiveRecord::Migration
  def change
    create_table :actividades do |t|
      t.integer :anio_escolar_id, :null => false
      t.integer :tipo_evento_id, :null => false
      t.datetime :fecha_hora_inicio, :null => false
      t.datetime :fecha_hora_fin, :null => false
      t.integer :tipo_actividad, :null => false
      t.string :nombre, :null => false
      t.text :detalle, :null => false
      t.binary :requiere_autorizacion, :null => false
      t.date :limite_autorizacion, :null => false
      t.date :inicio_notificacion
      t.date :fin_notificacion
      t.integer :frecuencia_dias_notificacion
      t.string :usuario, :null => false

      t.timestamps
    end
    
    add_index :actividades, [:anio_escolar_id], :name => "fk_actividades_aniosescolares"
    add_index :actividades, [:tipo_evento_id], :name => "fk_actividades_tiposeventos"
    
    execute "Alter Table \"actividades\" Add Constraint fk_actividades_aniosescolares Foreign Key (anio_escolar_id) References \"anios_escolares\"";
    execute "Alter Table \"actividades\" Add Constraint fk_actividades_tiposeventos Foreign Key (tipo_evento_id) References \"tipos_eventos\"";
  end
end
