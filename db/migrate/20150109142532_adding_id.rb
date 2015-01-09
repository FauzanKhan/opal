class AddingId < ActiveRecord::Migration
  def change
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
end
