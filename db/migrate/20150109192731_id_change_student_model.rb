class IdChangeStudentModel < ActiveRecord::Migration
  def change
	  	drop_table :students
	  	create_table :students, force: :cascade do |t|
	      t.string :email
	      t.string :password
	      t.string :password_digest
	      t.string :name
	      t.integer :college
	      t.string :course
	      t.string :branch
	      t.integer :year
	      t.string :education
	      t.string :experience
	      t.string :applications
  		end
  	end
end
