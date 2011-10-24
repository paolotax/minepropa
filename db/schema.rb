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

ActiveRecord::Schema.define(:version => 20111024141105) do

  create_table "adozioni", :force => true do |t|
    t.integer  "classe_id"
    t.integer  "libro_id"
    t.integer  "materia_id"
    t.integer  "nr_copie"
    t.integer  "nr_sezioni"
    t.string   "anno"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appunti", :force => true do |t|
    t.string   "destinatario"
    t.text     "note"
    t.string   "telefono"
    t.string   "stato",          :default => "",  :null => false
    t.date     "scadenza"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "scuola_id"
    t.integer  "position"
    t.string   "email"
    t.integer  "user_id"
    t.integer  "totale_copie",   :default => 0
    t.float    "totale_importo", :default => 0.0
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "appunti_to_import_bergami", :id => false, :force => true do |t|
    t.string  "destinatario"
    t.string  "Note1"
    t.string  "Note2"
    t.string  "Telefono"
    t.string  "IdScuola"
    t.string  "Stato"
    t.integer "scuola_id"
    t.string  "note"
  end

  create_table "appunto_righe", :force => true do |t|
    t.integer  "libro_id"
    t.integer  "appunto_id"
    t.integer  "quantita"
    t.decimal  "prezzo",          :precision => 8, :scale => 2
    t.boolean  "consegnato"
    t.boolean  "pagato"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "prezzo_unitario"
    t.string   "currency"
    t.decimal  "sconto",          :precision => 8, :scale => 2
    t.integer  "fattura_id"
  end

  add_index "appunto_righe", ["fattura_id"], :name => "index_appunto_righe_on_fattura_id"

  create_table "classi", :force => true do |t|
    t.integer  "classe"
    t.string   "sezione"
    t.integer  "nr_alunni"
    t.integer  "scuola_id"
    t.string   "spec_id"
    t.string   "sper_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "classi", ["scuola_id", "classe", "sezione"], :name => "index_classi_on_scuola_id_and_classe_and_sezione", :unique => true

  create_table "fatture", :force => true do |t|
    t.integer  "numero"
    t.date     "data"
    t.integer  "scuola_id"
    t.integer  "user_id"
    t.integer  "causale_id"
    t.boolean  "dettaglio_righe"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "condizioni_pagamento"
    t.boolean  "pagata"
    t.integer  "totale_copie",         :default => 0
    t.integer  "importo_fattura",      :default => 0
    t.integer  "totale_iva",           :default => 0
    t.string   "currency"
  end

  add_index "fatture", ["causale_id"], :name => "index_fatture_on_causale_id"
  add_index "fatture", ["scuola_id"], :name => "index_fatture_on_scuola_id"
  add_index "fatture", ["user_id", "causale_id", "numero"], :name => "index_fatture_per_utente_and_causale", :unique => true
  add_index "fatture", ["user_id"], :name => "index_fatture_on_user_id"

  create_table "feed_entries", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.string   "url"
    t.datetime "published_at"
    t.string   "guid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "giri", :force => true do |t|
    t.string   "titolo"
    t.date     "data"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "indirizzi", :force => true do |t|
    t.string   "destinatario"
    t.string   "indirizzo"
    t.string   "cap"
    t.string   "citta"
    t.string   "provincia"
    t.string   "tipo"
    t.integer  "indirizzable_id"
    t.string   "indirizzable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "gmaps"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "libri", :force => true do |t|
    t.string   "titolo"
    t.integer  "materia_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sigla"
    t.integer  "prezzo_copertina"
    t.integer  "prezzo_consigliato"
    t.string   "currency"
    t.float    "coefficente"
    t.string   "cm"
    t.string   "type"
  end

  create_table "materie", :force => true do |t|
    t.string   "materia"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scuole", :force => true do |t|
    t.string   "nome_scuola"
    t.string   "citta"
    t.string   "provincia"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "user_id"
    t.string   "ancestry"
    t.string   "telefono"
    t.string   "fax"
    t.string   "cellulare"
    t.string   "email"
    t.string   "partita_iva"
    t.string   "codice_fiscale"
    t.integer  "mie_adozioni_counter",     :default => 0
    t.integer  "appunti_in_corso_counter", :default => 0
  end

  add_index "scuole", ["ancestry"], :name => "index_scuole_on_ancestry"

  create_table "scuole_adozioni", :id => false, :force => true do |t|
    t.integer "IdAdozione",                 :null => false
    t.string  "IdScuola",     :limit => 12
    t.integer "IdClasse",                   :null => false
    t.string  "IdLibro",      :limit => 13
    t.integer "IdMateria",                  :null => false
    t.string  "Anno",         :limit => 4
    t.integer "Nuove"
    t.integer "Perse"
    t.integer "NrSez"
    t.integer "Saldo"
    t.integer "NrCopie"
    t.string  "IdTipo",       :limit => 2
    t.integer "TipoAdozione"
  end

  add_index "scuole_adozioni", ["IdAdozione"], :name => "IdAdozione", :unique => true
  add_index "scuole_adozioni", ["IdClasse"], :name => "IdClasse"

  create_table "scuole_classi", :id => false, :force => true do |t|
    t.integer "IdClasse",                :null => false
    t.string  "IdScuola",  :limit => 12
    t.integer "Classe",                  :null => false
    t.string  "Sezioni",   :limit => 20, :null => false
    t.string  "Sigla",     :limit => 5
    t.integer "NrSezioni"
    t.integer "NrAlunni"
  end

  create_table "scuole_to_export", :id => false, :force => true do |t|
    t.string  "Tipo",         :limit => 20
    t.string  "Nome",         :limit => 60
    t.string  "Citta",        :limit => 50
    t.string  "Indirizzo",    :limit => 80
    t.string  "CAP",          :limit => 5
    t.string  "Provincia",    :limit => 2
    t.string  "Scuola",       :limit => 30
    t.float   "longitude"
    t.float   "latitude"
    t.string  "Telefono",     :limit => 40
    t.string  "Fax",          :limit => 40
    t.string  "E_mail",       :limit => 50
    t.string  "IdTipo",       :limit => 2
    t.string  "ScuolaOrdine", :limit => 45
    t.string  "IdDirezione",  :limit => 12
    t.string  "IdScuola",     :limit => 12
    t.integer "id"
  end

  create_table "scuole_to_import_bergami", :id => false, :force => true do |t|
    t.integer "id"
    t.integer "ancestry"
    t.string  "nome_scuola"
    t.string  "citta"
    t.string  "provincia"
    t.integer "user_id"
    t.string  "telefono"
    t.string  "fax"
    t.string  "email"
    t.string  "destinatario"
    t.string  "indirizzo"
    t.string  "cap"
    t.string  "scuola_old_id"
    t.string  "ancestry_old"
    t.string  "tipo"
    t.float   "latitude"
    t.float   "longitude"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "tappe", :force => true do |t|
    t.integer  "giro_id"
    t.integer  "scuola_id"
    t.integer  "posizione"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "codice_fiscale"
    t.string   "partita_iva"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "visite", :force => true do |t|
    t.integer  "visitable_id"
    t.string   "visitable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.datetime "start"
    t.datetime "end"
    t.boolean  "all_day"
  end

  add_index "visite", ["user_id"], :name => "index_visite_on_user_id"
  add_index "visite", ["visitable_id", "visitable_type"], :name => "index_visite_on_visitable_id_and_visitable_type"

end
