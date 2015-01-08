class ChangeColumnType < ActiveRecord::Migration
  def change
  	change_column :tpos, :college, :string
  	change_column :tpos, :email, :string
  	change_column :students, :college, :string
  	change_column :students, :email, :string
  end
end
