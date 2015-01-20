class RemoveIdFromTpo < ActiveRecord::Migration
  def change
  	remove_column :tpos, :id
  end
end
