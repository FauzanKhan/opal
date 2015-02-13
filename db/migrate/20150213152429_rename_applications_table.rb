class RenameApplicationsTable < ActiveRecord::Migration
  def change
  	rename_table :applications, :job_applications
  end
end
