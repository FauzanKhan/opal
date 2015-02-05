class JobpostCourseAssociation < ActiveRecord::Migration
  def change
  	drop_table :jobpost_courses
  	change_table :eligible_branches do |t|
  		t.remove :eligible_branches, :jobpost_id
	  	t.remove :eligible_branches, :course_id
	  	t.remove :eligible_branches, :created_at
	  	t.remove :eligible_branches, :updated_at
	  	t.belongs_to :jobpost
	  	t.belongs_to :course
  	end
  end
end
