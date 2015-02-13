class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
    	t.belongs_to :jobpost
    	t.belongs_to :student
    end
    change_column :students, :phone_no, :string
  end
end
