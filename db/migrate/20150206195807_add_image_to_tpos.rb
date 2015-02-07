class AddImageToTpos < ActiveRecord::Migration
  def change
    add_column :tpos, :image, :string
  end
end
