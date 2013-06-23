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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130621082719) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "domains", force: true do |t|
    t.integer  "user_id",                   null: false
    t.string   "name",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "records_count", default: 0, null: false
  end

  add_index "domains", ["name"], name: "index_domains_on_name", unique: true, using: :btree
  add_index "domains", ["user_id"], name: "index_domains_on_user_id", using: :btree

  create_table "records", force: true do |t|
    t.integer  "domain_id",                 null: false
    t.string   "name",                      null: false
    t.string   "type",                      null: false
    t.integer  "ttl",        default: 3600, null: false
    t.integer  "priority",   default: 20,   null: false
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "records", ["domain_id", "name", "type", "priority"], name: "index_records_on_domain_id_and_name_and_type_and_priority", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
