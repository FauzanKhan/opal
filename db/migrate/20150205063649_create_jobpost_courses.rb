class CreateJobpostCourses < ActiveRecord::Migration
  def change
    create_table :jobpost_courses do |t|

      t.timestamps null: false
    end
  end
end
