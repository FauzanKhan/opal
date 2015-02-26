class TpoChanges < ActiveRecord::Migration
  
  def change
  
  	change_table :tpos do |t|
  		t.remove :college
  		t.string :phone_no
  	end

  	change_table :colleges do |t|
	  	t.references :tpo
	  end
  
  end

end
