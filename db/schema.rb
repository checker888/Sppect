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

ActiveRecord::Schema[7.0].define(version: 2025_01_07_084812) do
  create_table "admins", force: :cascade do |t|
    t.string "name", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "facilities", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "space_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_id"], name: "index_likes_on_space_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "name", null: false
    t.date "birthday", null: false
    t.string "address", null: false
    t.string "phonenumber", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "space_id"
    t.datetime "reserve_start_time", null: false
    t.datetime "reserve_end_time", null: false
    t.boolean "status", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_id"], name: "index_reservations_on_space_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id"
    t.integer "space_id"
    t.text "comment"
    t.datetime "posted_at", null: false
    t.integer "rating", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_id"], name: "index_reviews_on_space_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "space_facility_relations", force: :cascade do |t|
    t.integer "space_id"
    t.integer "facility_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_space_facility_relations_on_facility_id"
    t.index ["space_id"], name: "index_space_facility_relations_on_space_id"
  end

  create_table "space_genre_relations", force: :cascade do |t|
    t.integer "space_id"
    t.integer "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_space_genre_relations_on_genre_id"
    t.index ["space_id"], name: "index_space_genre_relations_on_space_id"
  end

  create_table "spaces", force: :cascade do |t|
    t.integer "owner_id"
    t.string "title", null: false
    t.string "subtitle"
    t.integer "price", null: false
    t.integer "capacity", null: false
    t.datetime "available_start_time", null: false
    t.datetime "available_end_time", null: false
    t.text "detail"
    t.decimal "average"
    t.boolean "approval"
    t.boolean "available"
    t.integer "payment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_spaces_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.date "birthday", null: false
    t.string "address", null: false
    t.string "phonenumber", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "space_facility_relations", "facilities"
  add_foreign_key "space_facility_relations", "spaces"
  add_foreign_key "space_genre_relations", "genres"
  add_foreign_key "space_genre_relations", "spaces"
end
