class CreateSocailProfiles < ActiveRecord::Migration
  def change
    create_table :social_profiles do |t|
    	t.references :students	
    	t.string :website
    	t.string :linkedin
    	t.string :github 
    end
  end
end
