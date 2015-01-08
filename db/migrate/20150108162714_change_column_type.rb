class ChangeColumnType < ActiveRecord::Migration
  def change
  	change_column :tpos, :college, :string
  	change_column :students, :college, :string
  end
end
