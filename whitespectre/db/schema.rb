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

ActiveRecord::Schema.define(version: 2019_10_02_145922) do

  create_table "group_events", force: :cascade do |t|
    t.boolean "draft", default: true, null: false
    t.string "name"
    t.text "description"
    t.date "start"
    t.date "stop"
    t.integer "duration"
    t.float "latitude"
    t.float "longitude"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_group_events_on_deleted_at"
    t.index ["draft"], name: "index_group_events_on_draft"
  end

end
