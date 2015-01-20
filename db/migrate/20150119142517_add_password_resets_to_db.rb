class AddPasswordResetsToDb < ActiveRecord::Migration
  def change
  	add_column :tpos, :reset_digest, :string
  	add_column :tpos, :reset_sent_at, :datetime
  	add_column :students, :reset_digest, :string
  	add_column :students, :reset_sent_at, :datetime
  end
end
