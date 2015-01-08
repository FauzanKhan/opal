class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :company
      t.string :position
      t.string :venue
      t.datetime :date_of_event
      t.text :description
      t.text :eligiblity
      t.string :student_list

      t.timestamps null: false
    end
  end
end
