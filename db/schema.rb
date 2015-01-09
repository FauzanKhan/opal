# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150109203452) do

  create_table "colleges", force: :cascade do |t|
    t.string   "college_name"
    t.string   "location"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "company"
    t.string   "position"
    t.string   "venue"
    t.datetime "date_of_event"
    t.text     "description"
    t.text     "eligiblity"
    t.string   "student_list"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "students", force: :cascade do |t|
    t.string  "email"
    t.string  "password"
    t.string  "password_digest"
    t.string  "name"
    t.string  "college"
    t.string  "course"
    t.string  "branch"
    t.integer "year"
    t.string  "education"
    t.string  "experience"
    t.string  "applications"
  end

  create_table "tpos", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.string   "name"
    t.string   "college"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

end
