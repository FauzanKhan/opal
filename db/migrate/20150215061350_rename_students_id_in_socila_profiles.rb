class RenameStudentsIdInSocilaProfiles < ActiveRecord::Migration
  def change
  	rename_column :social_profiles, :students_id, :student_id
  end
end
