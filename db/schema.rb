# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100914142629) do

  create_table "containers", :force => true do |t|
    t.text     "template"
    t.text     "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contenidos", :force => true do |t|
    t.string   "template"
    t.text     "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rotacion"
  end

  create_table "elementos", :force => true do |t|
    t.integer  "contenido_id", :null => false
    t.string   "valor"
    t.integer  "tipo_id",      :null => false
    t.integer  "ubicacion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.string   "identificador"
    t.string   "descripcion"
    t.integer  "container_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nivel"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tipo_contenidos", :force => true do |t|
    t.string   "template"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipo_elementos", :force => true do |t|
    t.string   "template"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.integer  "profile_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
