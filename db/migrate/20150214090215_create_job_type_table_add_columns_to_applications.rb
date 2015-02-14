class CreateJobTypeTableAddColumnsToApplications < ActiveRecord::Migration
  def change
    create_table :job_types do |t|
    	t.string :name
    end
    add_column :job_applications, :shortlisted, :integer, default: 0
    add_column :job_applications, :selected, :boolean, default: false
  end
end
