class Refactoring < ActiveRecord::Migration
  def change
  	change_column :tpos, :last_name, :string, after: :first_name
  	change_column :tpos, :job_title, :string, after: :college
  	change_column :students, :last_name, :string, after: :first_name
  	change_column :all_users, :last_name, :string, after: :first_name
  end
end
