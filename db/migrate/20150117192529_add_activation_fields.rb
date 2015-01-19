class AddActivationFields < ActiveRecord::Migration
  def change
  	add_column :tpos, :activation_digest, :string
  	add_column :tpos, :activated, :boolean, default: false
  	add_column :tpos, :activated_at, :datetime
  	add_column :students, :activation_digest, :string
  	add_column :students, :activated, :boolean, default: false
  	add_column :students, :activated_at, :datetime
  end
end
