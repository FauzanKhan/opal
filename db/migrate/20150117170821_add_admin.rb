class AddAdmin < ActiveRecord::Migration
  def change
  	add_column :tpos, :admin, :boolean, default: false
  end
end
