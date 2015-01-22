class AddTypeColToJobposts < ActiveRecord::Migration
  def change
  	rename_column :jobposts, :location, :location_id
  	change_column :jobposts, :location_id, :integer
  	add_column :jobposts, :job_type, :integer
  end
end
