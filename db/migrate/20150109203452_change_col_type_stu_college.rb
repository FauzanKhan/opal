class ChangeColTypeStuCollege < ActiveRecord::Migration
  def change
  	change_column :students, :college, :string
  end
end
