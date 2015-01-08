class CreateTpos < ActiveRecord::Migration
  def change
    create_table :tpos, id: false do |t|
      t.primary_key :email
      t.string :password
      t.string :name
      t.string :college
      t.timestamps null: false
    end
  end
end
