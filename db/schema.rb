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

ActiveRecord::Schema[7.0].define(version: 2022_09_21_093216) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "halls", force: :cascade do |t|
    t.string "name", null: false
    t.integer "capacity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_halls_on_name", unique: true
  end

  create_table "movies", force: :cascade do |t|
    t.string "title", null: false
    t.integer "length", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "seance_id", null: false
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seance_id"], name: "index_reservations_on_seance_id"
  end

  create_table "seances", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "hall_id", null: false
    t.datetime "start_time", null: false
    t.decimal "price", precision: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hall_id"], name: "index_seances_on_hall_id"
    t.index ["movie_id"], name: "index_seances_on_movie_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "seat"
    t.bigint "reservation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservation_id"], name: "index_tickets_on_reservation_id"
  end

  add_foreign_key "reservations", "seances"
  add_foreign_key "seances", "halls"
  add_foreign_key "seances", "movies"
  add_foreign_key "tickets", "reservations"
end
