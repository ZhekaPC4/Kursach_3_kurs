# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_28_112218) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ordered_teas", force: :cascade do |t|
    t.integer "amount"
    t.float "price_during_order"
    t.bigint "order_id"
    t.bigint "tea_id"
    t.index ["order_id"], name: "index_ordered_teas_on_order_id"
    t.index ["tea_id"], name: "index_ordered_teas_on_tea_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "delivery_data"
    t.float "total_price"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "current_status"
    t.string "status_commentary"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_statuses_on_order_id"
  end

  create_table "teas", force: :cascade do |t|
    t.integer "price", null: false
    t.string "name", null: false
    t.string "description"
    t.integer "weight", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "login", null: false
    t.string "password", null: false
    t.string "name", null: false
    t.string "surname"
    t.string "lastname"
    t.string "delivery_data"
    t.bigint "role_id", default: 3, null: false
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "ordered_teas", "orders"
  add_foreign_key "ordered_teas", "teas"
  add_foreign_key "orders", "users"
  add_foreign_key "statuses", "orders"
  add_foreign_key "users", "roles"
end
