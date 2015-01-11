class CreateAllUsers < ActiveRecord::Migration
  def change
    create_table :all_users do |t|
      t.string :email
      t.string :name
      t.string :college
      t.string :user_type

      t.timestamps null: false
    end
  end
end
