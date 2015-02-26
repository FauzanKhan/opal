class AddLocations < ActiveRecord::Migration
  def change
  	create_table :locations do |t|
  		t.string :location
  		t.integer :zone_id
  	end
  end
end
