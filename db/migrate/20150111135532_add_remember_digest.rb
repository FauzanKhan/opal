class AddRememberDigest < ActiveRecord::Migration
  def change
  	add_column :students, :remember_digest, :string 
  	add_column :tpos, :remember_digest, :string 
  end
end
