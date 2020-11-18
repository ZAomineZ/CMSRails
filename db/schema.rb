# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_12_143706) do

  create_table "category", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "resume"
    t.text "avat_cat"
    t.text "icon_cat"
    t.text "date_cat"
  end

  create_table "post", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "descr"
    t.datetime "date_post"
    t.text "img_original"
    t.text "img_medium"
    t.text "img_thumb"
    t.text "img_mini"
    t.string "category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.boolean "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
