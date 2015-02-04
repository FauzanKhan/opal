class ConversionToIds < ActiveRecord::Migration
  def change
  	change_table :tpos do |t|
	  	t.integer :college_id, after: :college
	  	t.change :user_type, :integer, default: 1
	  	t.change :last_name, :string, after: :first_name
	  	t.change :location_id, :integer, after: :college_id
	  	t.change :password, :string, after: :updated_at	
	  	t.change :job_title, :string, after: :last_name	
  	end

  	change_table :students do |t|
	  	t.rename :college, :college_id
	  	t.change :college_id, :integer
	  	t.change :user_type, :integer, default: 2
	  	t.rename :branch, :branch_id
	  	t.change :branch_id, :integer
	  	t.rename :course, :course_id
	  	t.change :course_id, :integer
	  	t.change :last_name, :string, after: :first_name
	  	t.change :location_id, :string, after: :college_id
	  	t.change :password, :string, after: :user_type
	  	t.change :password_digest, :string, after: :password	
  	end

  	change_column :all_users, :user_type, :integer
  end
end
