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

ActiveRecord::Schema.define(version: 20150226162341) do

  create_table "all_users", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "college"
    t.integer  "user_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "last_name"
  end

  create_table "branches", force: :cascade do |t|
    t.integer "course_id"
    t.string  "name"
  end

  add_index "branches", ["course_id"], name: "index_branches_on_course_id"

  create_table "colleges", force: :cascade do |t|
    t.string   "college_name"
    t.integer  "location_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
  end

  create_table "educations", force: :cascade do |t|
    t.integer "student_id"
    t.string  "degree"
    t.string  "institute"
    t.integer "percentage"
    t.integer "year_of_passing"
  end

  add_index "educations", ["student_id"], name: "index_educations_on_student_id"

  create_table "eligible_branches", force: :cascade do |t|
    t.integer "jobpost_id"
    t.integer "branch_id"
  end

  create_table "eligible_courses", force: :cascade do |t|
    t.integer "jobpost_id"
    t.integer "course_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.integer "student_id"
    t.string  "company_name"
    t.string  "position"
    t.text    "contributions"
    t.date    "start_date"
    t.date    "end_date"
  end

  add_index "experiences", ["student_id"], name: "index_experiences_on_student_id"

  create_table "job_applications", force: :cascade do |t|
    t.integer "jobpost_id"
    t.integer "student_id"
    t.integer "shortlisted", default: 0
    t.boolean "selected",    default: false
  end

  create_table "job_types", force: :cascade do |t|
    t.string "name"
  end

  create_table "jobposts", force: :cascade do |t|
    t.integer  "tpo_id"
    t.string   "company"
    t.string   "position"
    t.integer  "percentage_required"
    t.string   "required_branch"
    t.text     "other_requirements"
    t.text     "job_profile"
    t.string   "venue"
    t.integer  "location_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "job_type"
    t.text     "about_company"
    t.text     "instructions"
    t.integer  "year_required"
    t.date     "last_date"
    t.date     "drive_date"
  end

  add_index "jobposts", ["tpo_id", "created_at"], name: "index_jobposts_on_tpo_id_and_created_at"
  add_index "jobposts", ["tpo_id"], name: "index_jobposts_on_tpo_id"

  create_table "locations", force: :cascade do |t|
    t.string  "location"
    t.integer "zone_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer "student_id"
    t.string  "name"
    t.text    "description"
  end

  add_index "projects", ["student_id"], name: "index_projects_on_student_id"

  create_table "social_profiles", force: :cascade do |t|
    t.integer "student_id"
    t.string  "website"
    t.string  "linkedin"
    t.string  "github"
  end

  create_table "students", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.string   "password_digest"
    t.string   "first_name"
    t.integer  "college_id"
    t.integer  "course_id"
    t.integer  "branch_id"
    t.integer  "year"
    t.string   "education"
    t.string   "experience"
    t.string   "applications"
    t.string   "remember_digest"
    t.integer  "user_type",         default: 2
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "last_name"
    t.string   "location_id"
    t.string   "image"
    t.text     "skills"
    t.text     "achievements"
    t.integer  "year_of_passing"
    t.integer  "year_of_study"
    t.string   "phone_no"
    t.integer  "percentage"
  end

  create_table "tpos", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.string   "first_name"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.integer  "user_type",         default: 1
    t.string   "job_title"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "last_name"
    t.integer  "location_id"
    t.integer  "college_id"
    t.string   "image"
    t.string   "phone_no"
    t.string   "college"
  end

end
