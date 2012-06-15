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

ActiveRecord::Schema.define(:version => 20120615035738) do

  create_table "cuaderno_control_alumnos", :force => true do |t|
    t.integer  "CodigoColegio"
    t.date     "Fecha"
    t.string   "Seccion"
    t.integer  "CodigoAlumno"
    t.integer  "TipoEvento"
    t.text     "Detalle"
    t.string   "CodigoUsuario"
    t.datetime "FechaUsuario"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "cuaderno_control_revisions", :force => true do |t|
    t.integer  "CodigoColegio"
    t.date     "Fecha"
    t.string   "Seccion"
    t.integer  "CodigoAlumno"
    t.integer  "Revisado"
    t.text     "Observaciones"
    t.string   "CodigoUsuario"
    t.datetime "FechaUsuario"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "cuaderno_control_seccions", :force => true do |t|
    t.integer  "CodigoColegio"
    t.date     "Fecha"
    t.string   "Seccion"
    t.integer  "TipoEvento"
    t.text     "Detalle"
    t.string   "CodigoUsuario"
    t.datetime "FechaUsuario"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "cuaderno_controls", :force => true do |t|
    t.integer  "CodigoColegio"
    t.date     "Fecha"
    t.string   "Seccion"
    t.integer  "Estado"
    t.string   "CodigoUsuario"
    t.datetime "FechaUsuario"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "persona_autorizada_recojos", :force => true do |t|
    t.integer  "CodigoPersonaAutorizada"
    t.integer  "CodigoColegio"
    t.integer  "TipoDocumento"
    t.string   "NumeroDocumento"
    t.string   "Nombres"
    t.string   "ApellidoPaterno"
    t.string   "ApellidoMaterno"
    t.string   "Foto"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.text     "Observaciones"
  end

end
