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

ActiveRecord::Schema[8.0].define(version: 2025_01_25_113229) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "reservations", force: :cascade do |t|
    t.integer "participants"
    t.integer "status", default: 0
    t.bigint "test_schedule_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_schedule_id"], name: "index_reservations_on_test_schedule_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "test_schedules", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "deadline"
    t.integer "number_of_participants"
    t.bigint "test_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_id"], name: "index_test_schedules_on_test_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_registration_requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "password_digest"
    t.integer "role", default: 0
  end

  add_foreign_key "reservations", "test_schedules"
  add_foreign_key "reservations", "users"
  add_foreign_key "test_schedules", "tests"
end
