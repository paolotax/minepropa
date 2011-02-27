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

ActiveRecord::Schema.define(:version => 20110211140828) do

  create_table "appunti", :force => true do |t|
    t.string   "destinatario"
    t.text     "note"
    t.string   "telefono"
    t.string   "stato",        :default => "", :null => false
    t.date     "scadenza"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "scuola_id"
    t.integer  "position"
    t.string   "email"
    t.integer  "user_id"
  end

  create_table "scuole", :force => true do |t|
    t.string   "nome_scuola"
    t.string   "citta"
    t.string   "provincia"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "phone"
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "visite", :force => true do |t|
    t.date     "data"
    t.time     "ora_inizio"
    t.time     "ora_fine"
    t.string   "note"
    t.integer  "visitable_id"
    t.string   "visitable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visite", ["user_id"], :name => "index_visite_on_user_id"
  add_index "visite", ["visitable_id", "visitable_type"], :name => "index_visite_on_visitable_id_and_visitable_type"

end
