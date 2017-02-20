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

ActiveRecord::Schema.define(version: 20170220210256) do

  create_table "people", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.date     "date_of_birth"
    t.string   "gender"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.index ["email"], name: "index_people_on_email", unique: true
  end

  create_table "person_presentations", force: :cascade do |t|
    t.integer "person_id"
    t.integer "presentation_id"
    t.index ["person_id"], name: "index_person_presentations_on_person_id"
    t.index ["presentation_id"], name: "index_person_presentations_on_presentation_id"
  end

  create_table "presentations", force: :cascade do |t|
    t.binary   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "subject"
    t.date     "date"
  end

  create_table "staff", force: :cascade do |t|
    t.string   "pod"
    t.date     "started_at_company"
    t.integer  "person_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["person_id"], name: "index_staff_on_person_id"
  end

end
