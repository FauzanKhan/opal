class AddLastDateAndDriveDateToJobpost < ActiveRecord::Migration
  def change
  	add_column :jobposts, :last_date, :date
  	add_column :jobposts, :drive_date, :date
  end
end
