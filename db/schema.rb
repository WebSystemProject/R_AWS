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

ActiveRecord::Schema.define(version: 2021_02_25_213653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "usercomment", primary_key: "commentid", id: :serial, force: :cascade do |t|
    t.text "comment"
    t.datetime "createddate", null: false
    t.integer "userlist_id"
    t.integer "userphoto_id"
  end

  create_table "usercomments", force: :cascade do |t|
    t.integer "commentid"
    t.string "comment"
    t.time "createddate"
    t.integer "userid"
    t.integer "userphoto"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "userphoto_id"
    t.bigint "userlist_id"
    t.index ["userlist_id"], name: "index_usercomments_on_userlist_id"
    t.index ["userphoto_id"], name: "index_usercomments_on_userphoto_id"
  end

  create_table "userlist", primary_key: "userid", id: :integer, default: nil, force: :cascade do |t|
    t.string "username", limit: 50, null: false
    t.text "userphoto", null: false
  end

  create_table "userlists", force: :cascade do |t|
    t.integer "userid"
    t.string "username"
    t.string "userphoto"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "userphoto", primary_key: "photoid", id: :serial, force: :cascade do |t|
    t.text "photourl"
    t.datetime "createddate", null: false
    t.integer "userid"
  end

  create_table "userphotos", force: :cascade do |t|
    t.integer "photoid"
    t.string "photourl"
    t.time "createddate"
    t.integer "userid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "usercomment", "userlist", primary_key: "userid", name: "createdby", on_delete: :nullify
  add_foreign_key "usercomment", "userphoto", primary_key: "photoid", name: "photo", on_delete: :nullify
  add_foreign_key "usercomments", "userlists"
  add_foreign_key "usercomments", "userphotos"
  add_foreign_key "userphoto", "userlist", column: "userid", primary_key: "userid", name: "createdby", on_delete: :nullify
end
