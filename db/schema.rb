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

ActiveRecord::Schema.define(version: 20170107213719) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "order_outings", force: :cascade do |t|
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order_id"
    t.integer  "outing_id"
    t.index ["order_id"], name: "index_order_outings_on_order_id", using: :btree
    t.index ["outing_id"], name: "index_order_outings_on_outing_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "outings", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "base_cost"
    t.string   "image_url"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "politician_id"
    t.integer  "status",        default: 0
    t.index ["politician_id"], name: "index_outings_on_politician_id", using: :btree
  end

  create_table "politicians", force: :cascade do |t|
    t.string   "name"
    t.string   "party"
    t.integer  "multiplier"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "state"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "role",            default: 0
  end

  add_foreign_key "order_outings", "orders"
  add_foreign_key "order_outings", "outings"
  add_foreign_key "orders", "users"
  add_foreign_key "outings", "politicians"
end
