class JobpostAssociations < ActiveRecord::Migration
  def change
  	drop_table :eligible_courses
  	drop_table :eligible_branches
  	create_table :eligible_courses do |t|
  		t.belongs_to :jobpost
  		t.belongs_to :course
  		t.timestamps null: true
  	end 
  end
end
