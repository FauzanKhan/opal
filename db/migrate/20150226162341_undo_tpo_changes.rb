class UndoTpoChanges < ActiveRecord::Migration
  def change
  	add_column :tpos, :college, :string
  	remove_column :colleges, :tpo_id
  end
end
