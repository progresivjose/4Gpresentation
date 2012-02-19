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

ActiveRecord::Schema.define(:version => 20120219160229) do

  create_table "discos", :force => true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.string   "muestra"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "imagen"
  end

  create_table "fotos", :force => true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.string   "tipo"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "proyecto_id"
    t.string   "imagen"
    t.string   "imagen_uid"
  end

  add_index "fotos", ["proyecto_id"], :name => "index_fotos_on_proyecto_id"

  create_table "pista", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "disco_id"
  end

  add_index "pista", ["disco_id"], :name => "index_pista_on_disco_id"

  create_table "proyectos", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "videos", :force => true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "proyecto_id"
    t.string   "video"
  end

  add_index "videos", ["proyecto_id"], :name => "index_videos_on_proyecto_id"

end
