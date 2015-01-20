class AddPasswordDigestColumn < ActiveRecord::Migration
  def change
  	add_column :tpos, :password_digest, :string
  	add_column :students, :password_digest, :string
  end
end
