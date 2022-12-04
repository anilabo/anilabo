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

ActiveRecord::Schema[7.0].define(version: 2022_11_29_142231) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "anime_companies", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "anime_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["anime_id"], name: "index_anime_companies_on_anime_id"
    t.index ["company_id"], name: "index_anime_companies_on_company_id"
  end

  create_table "animes", force: :cascade do |t|
    t.string "public_uid", null: false
    t.string "title", default: "", null: false
    t.string "title_short1", default: ""
    t.string "title_short2", default: ""
    t.string "title_short3", default: ""
    t.string "title_en", default: "", null: false
    t.string "public_url", default: "", null: false
    t.string "twitter_account", default: "", null: false
    t.string "twitter_hash_tag", default: "", null: false
    t.integer "cours_id", default: 0, null: false
    t.integer "sex", default: 0, null: false
    t.integer "sequel", default: 0, null: false
    t.integer "city_code", default: 0, null: false
    t.string "city_name", default: "", null: false
    t.string "thumbnail_url", default: "", null: false
    t.integer "year", null: false
    t.integer "season", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["public_uid"], name: "index_animes_on_public_uid", unique: true
    t.index ["thumbnail_url"], name: "index_animes_on_thumbnail_url"
    t.index ["title"], name: "index_animes_on_title", unique: true
    t.index ["title_en"], name: "index_animes_on_title_en"
    t.index ["title_short1"], name: "index_animes_on_title_short1"
    t.index ["title_short2"], name: "index_animes_on_title_short2"
    t.index ["year", "season"], name: "index_animes_on_year_and_season"
  end

  create_table "companies", force: :cascade do |t|
    t.string "public_uid", null: false
    t.string "name", null: false
    t.string "name_en"
    t.string "public_url", default: ""
    t.string "address", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_companies_on_name"
    t.index ["name_en"], name: "index_companies_on_name_en"
    t.index ["public_uid"], name: "index_companies_on_public_uid", unique: true
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "operative_user_id", null: false
    t.integer "passive_user_id"
    t.integer "anime_id"
    t.integer "watch_log_id"
    t.integer "action", default: 0, null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["anime_id"], name: "index_notifications_on_anime_id"
    t.index ["operative_user_id"], name: "index_notifications_on_operative_user_id"
    t.index ["passive_user_id"], name: "index_notifications_on_passive_user_id"
    t.index ["watch_log_id"], name: "index_notifications_on_watch_log_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_animes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "anime_id", null: false
    t.integer "progress", default: 0, null: false
    t.text "opinion"
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_spoiler", default: false
    t.index ["anime_id"], name: "index_user_animes_on_anime_id"
    t.index ["user_id"], name: "index_user_animes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "uid", null: false
    t.string "display_name", null: false
    t.string "photo_url", null: false
    t.string "password_digest"
    t.text "introduction", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "anime_companies", "animes"
  add_foreign_key "anime_companies", "companies"
  add_foreign_key "user_animes", "animes"
  add_foreign_key "user_animes", "users"
end
