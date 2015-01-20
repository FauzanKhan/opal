class RenameType < ActiveRecord::Migration
  def change
  	rename_column :tpos, :type, :user_type
  	rename_column :students, :type, :user_type
  end
end
