class AddLocationIds < ActiveRecord::Migration
  def change
  	add_column :tpos, :location_id, :integer
  	add_column :students, :location_id, :integer
  	rename_column :colleges, :location, :location_id
  	change_column :colleges, :location_id, :integer
  end
end
