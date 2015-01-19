class ModelRefactoring < ActiveRecord::Migration
  def change
  	change_table :tpos do |t|
  		t.rename :name, :first_name
  		t.string :last_name, after: :first_name
  		t.change :job_title, :string, after: :college
  		t.change :password, :string, before: :password_digest
  		t.remove :remember_token
  	end

  	change_table :students do |t|
  		t.rename :name, :first_name
  		t.string :last_name, after: :first_name
  		t.remove :remember_token
  	end

  	change_table :all_users do |t|
  		t.rename :name, :first_name
  		t.string :last_name, after: :first_name
  		t.remove :remember_token
  	end

  end
end
