class JobpostAdditions < ActiveRecord::Migration
  def change
  	change_table :jobposts do |t|
  		t.text :about_company, after: :company
  		t.remove :required_branches
  		t.text :instructions
  		t.change :req_percentage, :integer
  		t.rename :req_percentage, :percentage_required
  		t.integer :year_required, after: :percentage_required
  	end
  	remove_timestamps :branches
  	remove_timestamps :branches
  	remove_timestamps :courses
  	remove_timestamps :eligible_courses
    remove_timestamps :eligible_branches
  	#remove_timestamps :locations
  	#drop_table :posts
  end
end
