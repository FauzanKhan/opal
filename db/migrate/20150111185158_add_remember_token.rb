class AddRememberToken < ActiveRecord::Migration
  def change
  	add_column :students, :remember_token, :string 
  	add_column :tpos, :remember_token, :string 
  end
end
