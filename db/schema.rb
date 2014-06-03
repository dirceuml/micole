# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140603140915) do

  create_table "actividades", :force => true do |t|
    t.integer  "anio_escolar_id",                                           :null => false
    t.integer  "tipo_evento_id",                                            :null => false
    t.datetime "fecha_hora_inicio",                                         :null => false
    t.datetime "fecha_hora_fin",                                            :null => false
    t.integer  "tipo_actividad",                                            :null => false
    t.string   "nombre",                                                    :null => false
    t.text     "detalle",                                                   :null => false
    t.date     "inicio_notificacion"
    t.date     "fin_notificacion"
    t.integer  "frecuencia_dias_notificacion"
    t.string   "usuario",                                                   :null => false
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.integer  "requiere_autorizacion",                      :default => 0, :null => false
    t.date     "limite_autorizacion"
    t.integer  "estado",                                     :default => 1, :null => false
    t.string   "observacion",                  :limit => 50
    t.integer  "alcance_colegio"
  end

  add_index "actividades", ["anio_escolar_id"], :name => "fk_actividades_aniosescolares"
  add_index "actividades", ["tipo_evento_id"], :name => "fk_actividades_tiposeventos"

  create_table "actividades_secciones", :force => true do |t|
    t.integer  "actividad_id", :null => false
    t.integer  "seccion_id",   :null => false
    t.string   "usuario",      :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "actividades_secciones", ["actividad_id", "seccion_id"], :name => "ak_actividades_secciones", :unique => true
  add_index "actividades_secciones", ["actividad_id"], :name => "fk_activsecciones_actividades"
  add_index "actividades_secciones", ["seccion_id"], :name => "fk_activsecciones_secciones"

  create_table "alumnos", :force => true do |t|
    t.string   "nombres",                           :null => false
    t.string   "apellido_paterno",                  :null => false
    t.string   "apellido_materno"
    t.date     "fecha_nacimiento"
    t.string   "telefono_fijo"
    t.string   "telefono_movil"
    t.text     "direccion"
    t.string   "correo"
    t.string   "foto"
    t.string   "usuario_nom",                       :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "dni"
    t.integer  "salida_con_persona", :default => 0, :null => false
  end

  create_table "alumnos_personas_vinculadas", :force => true do |t|
    t.integer  "persona_vinculada_id",                :null => false
    t.integer  "alumno_id",                           :null => false
    t.integer  "tipo_vinculo",                        :null => false
    t.integer  "vigencia_vinculo",                    :null => false
    t.date     "inicio_vigencia",                     :null => false
    t.string   "usuario",                             :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "apoderado",            :default => 0, :null => false
    t.integer  "autoriza_actividad",   :default => 0, :null => false
    t.integer  "revisa_control",       :default => 0, :null => false
    t.date     "fin_vigencia"
    t.integer  "notificar_ingreso",    :default => 0, :null => false
    t.integer  "notificar_salida",     :default => 0, :null => false
  end

  add_index "alumnos_personas_vinculadas", ["alumno_id"], :name => "fk_alumnospersonas_alumnos"
  add_index "alumnos_personas_vinculadas", ["persona_vinculada_id", "alumno_id"], :name => "ak_alumnospersonasvinculadas", :unique => true
  add_index "alumnos_personas_vinculadas", ["persona_vinculada_id"], :name => "fk_alumnospersonas_personas"

  create_table "anios_alumnos", :force => true do |t|
    t.integer  "anio_escolar_id",                :null => false
    t.integer  "alumno_id",                      :null => false
    t.string   "usuario",                        :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "seccion_id",                     :null => false
    t.integer  "estado",          :default => 1, :null => false
  end

  add_index "anios_alumnos", ["alumno_id"], :name => "fk_aniosalumnos_alumno"
  add_index "anios_alumnos", ["anio_escolar_id", "alumno_id"], :name => "ak_anios_alumnos", :unique => true
  add_index "anios_alumnos", ["anio_escolar_id"], :name => "fk_aniosalumnos_anioescolar"
  add_index "anios_alumnos", ["seccion_id"], :name => "fk_aniosalumnos_secciones"

  create_table "anios_escolares", :force => true do |t|
    t.integer  "colegio_id",                   :null => false
    t.integer  "anio",                         :null => false
    t.date     "inicio_clases"
    t.date     "fin_clases"
    t.string   "usuario",                      :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "activo",        :default => 1, :null => false
  end

  add_index "anios_escolares", ["colegio_id", "anio"], :name => "ak_aniosescolares", :unique => true
  add_index "anios_escolares", ["colegio_id"], :name => "fk_aniosescolares_colegios"

  create_table "asistencias", :force => true do |t|
    t.integer  "anio_alumno_id",                      :null => false
    t.datetime "fecha_hora",                          :null => false
    t.integer  "persona_vinculada_id"
    t.string   "usuario",                             :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "tipo_movimiento",      :default => 2, :null => false
  end

  add_index "asistencias", ["anio_alumno_id", "fecha_hora"], :name => "ak_asistencias", :unique => true
  add_index "asistencias", ["anio_alumno_id"], :name => "fk_asistencias_aniosalumnos"
  add_index "asistencias", ["persona_vinculada_id"], :name => "fk_asistencias_personas"

  create_table "autorizaciones", :force => true do |t|
    t.integer  "actividad_id",            :null => false
    t.integer  "alumno_id",               :null => false
    t.integer  "persona_vinculada_id"
    t.datetime "fecha_hora_autorizacion"
    t.string   "usuario",                 :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "respuesta"
    t.integer  "asistencia"
  end

  add_index "autorizaciones", ["actividad_id", "alumno_id"], :name => "ak_autorizaciones", :unique => true
  add_index "autorizaciones", ["actividad_id"], :name => "fk_autorizaciones_actividades"
  add_index "autorizaciones", ["alumno_id"], :name => "fk_autorizaciones_alumnos"
  add_index "autorizaciones", ["persona_vinculada_id"], :name => "fk_autorizaciones_personas"

  create_table "colegios", :force => true do |t|
    t.string   "nombre",                                 :null => false
    t.string   "ruc"
    t.text     "direccion"
    t.string   "telefono"
    t.string   "correo"
    t.string   "logo"
    t.string   "director"
    t.string   "usuario",                                :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "estado",                  :default => 1, :null => false
    t.integer  "notificar_inasistencia",  :default => 0, :null => false
    t.integer  "grado_usuario"
    t.integer  "notificar_tardanza",      :default => 0, :null => false
    t.integer  "registrar_hora_tardanza", :default => 0, :null => false
    t.time     "hora_inicio_tardanza"
  end

  add_index "colegios", ["nombre"], :name => "ui_colegios_nombre", :unique => true

  create_table "controles_asistencias", :force => true do |t|
    t.integer  "anio_alumno_id",  :null => false
    t.integer  "tipo_asistencia", :null => false
    t.string   "usuario",         :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.date     "fecha",           :null => false
  end

  create_table "cuaderno_controles_eventos", :force => true do |t|
    t.integer  "cuaderno_control_id", :null => false
    t.integer  "tipo_evento_id",      :null => false
    t.integer  "alumno_id"
    t.text     "descripcion",         :null => false
    t.string   "usuario",             :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.date     "fecha_evento"
  end

  add_index "cuaderno_controles_eventos", ["cuaderno_control_id", "tipo_evento_id"], :name => "idx_cuadcontrolevento_evento"
  add_index "cuaderno_controles_eventos", ["cuaderno_control_id"], :name => "fk_cuacontrolevento_cuacontrol"
  add_index "cuaderno_controles_eventos", ["tipo_evento_id"], :name => "fk_cuacontrolevento_tipoevent"

  create_table "cuaderno_controles_revisiones", :force => true do |t|
    t.integer  "cuaderno_control_id",                 :null => false
    t.integer  "alumno_id",                           :null => false
    t.integer  "persona_vinculada_id"
    t.datetime "fecha_hora_revision"
    t.text     "observaciones"
    t.string   "usuario",                             :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "revisado",             :default => 0, :null => false
  end

  add_index "cuaderno_controles_revisiones", ["alumno_id"], :name => "fk_cuacontrolrevision_alumno"
  add_index "cuaderno_controles_revisiones", ["cuaderno_control_id", "alumno_id"], :name => "ak_cuaderno_controles_revision", :unique => true
  add_index "cuaderno_controles_revisiones", ["cuaderno_control_id"], :name => "fk_cuacontrolrevis_cuacontrol"
  add_index "cuaderno_controles_revisiones", ["persona_vinculada_id"], :name => "fk_cuacontrolrevision_pervincu"

  create_table "cuadernos_controles", :force => true do |t|
    t.integer  "seccion_id", :null => false
    t.date     "fecha",      :null => false
    t.integer  "estado",     :null => false
    t.string   "usuario",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cuadernos_controles", ["seccion_id", "fecha"], :name => "ui_cuadernocontrol_fechaseccion", :unique => true
  add_index "cuadernos_controles", ["seccion_id"], :name => "fk_cuadernoscontroles_secciones"

  create_table "curriculos", :force => true do |t|
    t.integer  "grado_id",   :null => false
    t.integer  "curso_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "curriculos", ["curso_id"], :name => "fk_curriculos_cursos"
  add_index "curriculos", ["grado_id", "curso_id"], :name => "ak_curriculos", :unique => true
  add_index "curriculos", ["grado_id"], :name => "fk_curriculos_grados"

  create_table "cursos", :force => true do |t|
    t.string   "descripcion", :null => false
    t.string   "usuario",     :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "abreviatura"
  end

  add_index "cursos", ["abreviatura"], :name => "idx_curso_abreviatura"
  add_index "cursos", ["descripcion"], :name => "ak_cursos_descripcion", :unique => true

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "grados", :force => true do |t|
    t.integer  "anio_escolar_id",                :null => false
    t.integer  "grado",                          :null => false
    t.string   "usuario",                        :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "nivel",           :default => 1, :null => false
  end

  add_index "grados", ["anio_escolar_id", "grado", "nivel"], :name => "ak_grados", :unique => true
  add_index "grados", ["anio_escolar_id"], :name => "fk_grados_aniosescolares"

  create_table "listas_valores", :force => true do |t|
    t.integer  "tabla",       :null => false
    t.integer  "item",        :null => false
    t.string   "descripcion", :null => false
    t.string   "abreviatura"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "listas_valores", ["tabla", "item"], :name => "ak_listas_valores", :unique => true

  create_table "menus", :force => true do |t|
    t.integer  "menu_id",        :null => false
    t.integer  "transaccion_id", :null => false
    t.integer  "orden"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "menus", ["menu_id", "transaccion_id"], :name => "ak_menus", :unique => true
  add_index "menus", ["menu_id"], :name => "fk_menus_transaccionesmenu"
  add_index "menus", ["transaccion_id"], :name => "fk_menus_transacciones"

  create_table "notas", :force => true do |t|
    t.integer  "anio_alumno_id", :null => false
    t.integer  "curso_id",       :null => false
    t.integer  "tipo_nota_id",   :null => false
    t.decimal  "nota",           :null => false
    t.text     "observaciones"
    t.string   "usuario",        :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.date     "fecha_nota",     :null => false
  end

  add_index "notas", ["anio_alumno_id", "curso_id", "tipo_nota_id"], :name => "ak_notas", :unique => true
  add_index "notas", ["anio_alumno_id"], :name => "fk_notas_alumnos"
  add_index "notas", ["curso_id"], :name => "fk_notas_cursos"
  add_index "notas", ["tipo_nota_id"], :name => "fk_notas_tiposnotas"

  create_table "perfiles", :force => true do |t|
    t.string   "descripcion", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "perfiles", ["descripcion"], :name => "ak_perfiles_descripcion", :unique => true

  create_table "perfiles_permisos", :force => true do |t|
    t.integer  "perfil_id",  :null => false
    t.integer  "permiso_id", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "perfiles_permisos", ["perfil_id", "permiso_id"], :name => "ak_perfiles_permisos", :unique => true
  add_index "perfiles_permisos", ["perfil_id"], :name => "fk_perfilespermisos_perfiles"
  add_index "perfiles_permisos", ["permiso_id"], :name => "fk_perfilespermisos_permisos"

  create_table "perfiles_transacciones", :force => true do |t|
    t.integer  "perfil_id",      :null => false
    t.integer  "transaccion_id", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "perfiles_transacciones", ["perfil_id", "transaccion_id"], :name => "ak_perfiles_transacciones", :unique => true
  add_index "perfiles_transacciones", ["perfil_id"], :name => "fk_perfiltransaccion_perfil"
  add_index "perfiles_transacciones", ["transaccion_id"], :name => "fk_perfiltransaccion_transac"

  create_table "permisos", :force => true do |t|
    t.string   "action",        :null => false
    t.string   "subject_class", :null => false
    t.integer  "subject_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "personas_vinculadas", :force => true do |t|
    t.integer  "tipo_documento",   :null => false
    t.string   "numero_documento", :null => false
    t.string   "nombres",          :null => false
    t.string   "apellido_paterno", :null => false
    t.string   "apellido_materno"
    t.string   "telefono_fijo"
    t.string   "telefono_movil"
    t.string   "correo"
    t.string   "foto"
    t.string   "user",             :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "personas_vinculadas", ["tipo_documento", "numero_documento"], :name => "ak_personas_vinculadas", :unique => true

  create_table "secciones", :force => true do |t|
    t.integer  "grado_id",   :null => false
    t.string   "seccion",    :null => false
    t.string   "usuario",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "secciones", ["grado_id", "seccion"], :name => "ak_secciones", :unique => true
  add_index "secciones", ["grado_id"], :name => "fk_secciones_grados"

  create_table "tipos_eventos", :force => true do |t|
    t.integer  "colegio_id",                            :null => false
    t.string   "descripcion",                           :null => false
    t.integer  "alcance",                               :null => false
    t.string   "usuario",                               :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "notificacion_inmediata", :default => 0, :null => false
    t.integer  "cuaderno_control",       :default => 0, :null => false
    t.integer  "obligatorio_fecha",      :default => 0, :null => false
  end

  add_index "tipos_eventos", ["colegio_id", "descripcion"], :name => "idx_descripcion_tiposevent", :unique => true
  add_index "tipos_eventos", ["colegio_id"], :name => "fk_tiposeventos_colegios"

  create_table "tipos_notas", :force => true do |t|
    t.integer  "anio_escolar_id", :null => false
    t.string   "descripcion",     :null => false
    t.string   "usuario",         :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "abreviatura"
  end

  add_index "tipos_notas", ["abreviatura"], :name => "idx_tiponota_abreviatura"
  add_index "tipos_notas", ["anio_escolar_id", "descripcion"], :name => "idx_tiposeventos_descripcion", :unique => true
  add_index "tipos_notas", ["anio_escolar_id"], :name => "fk_tiposnotas_anioescolar"

  create_table "transacciones", :force => true do |t|
    t.string   "descripcion", :null => false
    t.integer  "tipo",        :null => false
    t.string   "ruta",        :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "transacciones", ["descripcion"], :name => "ak_transacciones_descripcion", :unique => true

  create_table "usuarios", :force => true do |t|
    t.integer  "colegio_id",                                :null => false
    t.string   "usuario",                                   :null => false
    t.string   "nombre",                                    :null => false
    t.string   "clave_hash",                                :null => false
    t.integer  "perfil_id",                                 :null => false
    t.integer  "persona_vinculada_id"
    t.string   "correo"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "clave_salt",           :default => "clave", :null => false
    t.integer  "notificado",           :default => 0,       :null => false
    t.date     "fecha_clave"
    t.integer  "alcance_colegio"
    t.integer  "alumno_id"
    t.integer  "estado",               :default => 1,       :null => false
  end

  add_index "usuarios", ["colegio_id", "usuario"], :name => "ak_usuarios", :unique => true
  add_index "usuarios", ["colegio_id"], :name => "fk_usuarios_colegios"
  add_index "usuarios", ["perfil_id"], :name => "fk_usuarios_perfiles"
  add_index "usuarios", ["persona_vinculada_id"], :name => "fk_usuarios_personas"

  create_table "usuarios_secciones", :force => true do |t|
    t.integer  "usuario_id",                               :null => false
    t.integer  "seccion_id",                               :null => false
    t.integer  "verifica_cuaderno_control", :default => 0, :null => false
    t.integer  "asigna_actividad",          :default => 0, :null => false
    t.integer  "revisa_autorizacion",       :default => 0, :null => false
    t.integer  "revisa_asistencia",         :default => 0, :null => false
    t.string   "usuario_nom",                              :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "usuarios_secciones", ["seccion_id"], :name => "fk_usuariossecciones_seccion"
  add_index "usuarios_secciones", ["usuario_id", "seccion_id"], :name => "ak_usuarios_secciones", :unique => true
  add_index "usuarios_secciones", ["usuario_id"], :name => "fk_usuariossecciones_usuario"

end
