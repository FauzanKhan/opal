class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :tpos, :college_id, :college
  	rename_column :students, :college_id, :college
  end
end
