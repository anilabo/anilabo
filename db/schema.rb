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

ActiveRecord::Schema[7.0].define(version: 2022_10_16_101206) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animes", force: :cascade do |t|
    t.string "public_uid", default: "", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["public_uid"], name: "index_animes_on_public_uid", unique: true
    t.index ["title"], name: "index_animes_on_title", unique: true
    t.index ["title_en"], name: "index_animes_on_title_en", unique: true
  end

end
