class AddIndexToEmailsInDb < ActiveRecord::Migration
	#This uses a Rails method called add_index to add an index on the email column of the users table. The index by itself doesn’t enforce uniqueness, but the option unique: true does.
  def change
  	add_index :tpos, :email, unique: true
  	add_index :students, :email, unique: true
  end
end
