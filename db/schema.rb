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

ActiveRecord::Schema.define(version: 20160114103536) do

  create_table "person", id: false, force: :cascade do |t|
    t.integer "number", limit: 4
    t.string  "name",   limit: 255
  end

  create_table "product_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "father_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.decimal  "price",                      precision: 10, default: 0
    t.boolean  "discount",                                  default: true
    t.boolean  "top_and_down",                              default: true
    t.date     "product_date"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.integer  "type_id",      limit: 4
    t.string   "image",        limit: 255
    t.text     "describtion",  limit: 65535
    t.integer  "user_id",      limit: 4
  end

  create_table "students", force: :cascade do |t|
    t.string "name", limit: 225
  end

  create_table "types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",            limit: 255
    t.string   "email",               limit: 255
    t.string   "realname",            limit: 255
    t.integer  "gender",              limit: 4
    t.integer  "province",            limit: 4
    t.integer  "city",                limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.date     "birthday"
    t.text     "detail_address",      limit: 65535
    t.string   "password_digest",     limit: 255
    t.string   "auth_token",          limit: 255
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
  end

end
