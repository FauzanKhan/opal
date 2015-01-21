class ChangeColumnNamesInJobpostModel < ActiveRecord::Migration
  def change
  	 change_table :jobposts do |t|
  	 	t.rename :company_name, :company
  	 	t.rename :position_offered, :position
  	 	t.rename :state, :location
  	 	t.rename :required_percentage, :req_percentage
  	 end
  end
end
