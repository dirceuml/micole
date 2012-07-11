class AddForeignKey < ActiveRecord::Migration
  def change
    ##
    execute "Alter Table \"anios_alumnos\" Add Constraint fk_aniosalumnos_alumnos Foreign Key (alumno_id) References \"alumnos\"";
     
    ##
    add_index :cuaderno_controles_eventos, [:cuaderno_control_id, :tipo_evento_id], :name => "ak_cuaderno_controles_eventos", :unique => true
    add_index :cuaderno_controles_eventos, [:tipo_evento_id], :name => "fk_cuacontrolevento_tipoevent"
    
    execute "Alter Table \"cuaderno_controles_eventos\" Add Constraint fk_cuacontrolevento_tipoevent Foreign Key (tipo_evento_id) References \"tipos_eventos\"";

    ##    
    add_index :cuaderno_controles_revisiones, [:cuaderno_control_id, :alumno_id], :name => "ak_cuaderno_controles_revision", :unique => true
    add_index :cuaderno_controles_revisiones, [:alumno_id], :name => "fk_cuacontrolrevision_alumno"
    add_index :cuaderno_controles_revisiones, [:persona_vinculada_id], :name => "fk_cuacontrolrevision_pervincu"
    
    execute "Alter Table \"cuaderno_controles_revisiones\" Add Constraint fk_cuacontrolrevision_pervincu Foreign Key (persona_vinculada_id) References \"personas_vinculadas\"";

    ##    
    add_index :tipos_eventos, [:colegio_id, :descripcion], :name => "idx_descripcion_tiposevent", :unique => true
    add_index :tipos_eventos, [:colegio_id], :name => "fk_tiposeventos_colegios"
    
    execute "Alter Table \"tipos_eventos\" Add Constraint fk_tiposeventos_colegios Foreign Key (colegio_id) References \"colegios\"";

    ##    
    add_index :tipos_notas, [:anio_escolar_id, :descripcion], :name => "idx_tiposeventos_descripcion", :unique => true
    add_index :tipos_notas, [:anio_escolar_id], :name => "fk_tiposnotas_anioescolar"
    
    execute "Alter Table \"tipos_notas\" Add Constraint fk_tiposnotas_anioescolar Foreign Key (anio_escolar_id) References \"anios_escolares\"";

    ##    
    add_index :usuarios, [:colegio_id, :usuario], :name => "ak_usuarios", :unique => true
    add_index :usuarios, [:colegio_id], :name => "fk_usuarios_colegios"
    add_index :usuarios, [:perfil_id], :name => "fk_usuarios_perfiles"
    add_index :usuarios, [:persona_vinculada_id], :name => "fk_usuarios_personas"
    
    execute "Alter Table \"usuarios\" Add Constraint fk_usuarios_colegios Foreign Key (colegio_id) References \"colegios\"";
    execute "Alter Table \"usuarios\" Add Constraint fk_usuarios_perfiles Foreign Key (perfil_id) References \"perfiles\"";
    execute "Alter Table \"usuarios\" Add Constraint fk_usuarios_personas Foreign Key (persona_vinculada_id) References \"personas_vinculadas\"";
    
    ##    
    add_index :notas, [:anio_alumno_id, :curso_id, :tipo_nota_id], :name => "ak_notas", :unique => true
    add_index :notas, [:anio_alumno_id], :name => "fk_notas_alumnos"
    add_index :notas, [:curso_id], :name => "fk_notas_cursos"
    add_index :notas, [:tipo_nota_id], :name => "fk_notas_tiposnotas"
    
    execute "Alter Table \"notas\" Add Constraint fk_notas_aniosalumnos Foreign Key (anio_alumno_id) References \"anios_alumnos\"";
    execute "Alter Table \"notas\" Add Constraint fk_notas_cursos Foreign Key (curso_id) References \"cursos\"";
    execute "Alter Table \"notas\" Add Constraint fk_notas_tiposnotas Foreign Key (tipo_nota_id) References \"tipos_notas\"";
    
    ##    
    add_index :autorizaciones, [:actividad_id, :alumno_id], :name => "ak_autorizaciones", :unique => true
    add_index :autorizaciones, [:actividad_id], :name => "fk_autorizaciones_actividades"
    add_index :autorizaciones, [:alumno_id], :name => "fk_autorizaciones_alumnos"
    add_index :autorizaciones, [:persona_vinculada_id], :name => "fk_autorizaciones_personas"
    
    execute "Alter Table \"autorizaciones\" Add Constraint fk_autorizaciones_actividades Foreign Key (actividad_id) References \"actividades\"";
    execute "Alter Table \"autorizaciones\" Add Constraint fk_autorizaciones_alumnos Foreign Key (alumno_id) References \"alumnos\"";
    execute "Alter Table \"autorizaciones\" Add Constraint fk_autorizaciones_personas Foreign Key (persona_vinculada_id) References \"personas_vinculadas\"";
    
    ##    
    add_index :asistencias, [:anio_alumno_id, :fecha_hora], :name => "ak_asistencias", :unique => true
    add_index :asistencias, [:anio_alumno_id], :name => "fk_asistencias_aniosalumnos"
    add_index :asistencias, [:persona_vinculada_id], :name => "fk_asistencias_personas"
    
    execute "Alter Table \"asistencias\" Add Constraint fk_asistencias_aniosalumnos Foreign Key (anio_alumno_id) References \"anios_alumnos\"";
    execute "Alter Table \"asistencias\" Add Constraint fk_asistencias_personas Foreign Key (persona_vinculada_id) References \"personas_vinculadas\"";
    
  end
end
