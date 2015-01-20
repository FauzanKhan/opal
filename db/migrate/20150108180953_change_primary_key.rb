class ChangePrimaryKey < ActiveRecord::Migration
  def change
  	change_column :tpos, :email, :string
  	change_column :students, :email, :string
  end
end
