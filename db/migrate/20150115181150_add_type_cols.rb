class AddTypeCols < ActiveRecord::Migration
  def change
  	add_column :tpos, :type, :string
  	add_column :tpos, :job_title, :string
  	add_column :students, :type, :string
  end
end
