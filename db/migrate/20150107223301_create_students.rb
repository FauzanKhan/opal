class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students, id: false do |t|
      t.primary_key :email
      t.string :password
      t.string :name
      t.integer :college
      t.string :course
      t.string :branch
      t.integer :year
      t.string :applications

      t.timestamps null: false
    end
  end
end
