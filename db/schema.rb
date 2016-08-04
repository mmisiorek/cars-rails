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

ActiveRecord::Schema.define(version: 20160730112425) do

  create_table "cars", force: :cascade do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "brand"
    t.string   "model"
    t.datetime "manufactured_date"
    t.string   "photo_file_name"
    t.string   "registration_number"
    t.boolean  "is_available"
    t.integer  "photo_id"
    t.integer  "user_id"
  end

  add_index "cars", ["photo_id"], name: "index_cars_on_photo_id"

  create_table "documents", force: :cascade do |t|
    t.string   "original_filename"
    t.string   "real_filename"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "path"
    t.string   "token"
    t.integer  "user_id"
  end

# Could not dump table "user_tokens" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.string   "salt"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
