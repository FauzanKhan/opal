class AdditionsToStudentModel < ActiveRecord::Migration
  def change
  	change_table :students do |t|
  		t.string :image
  		t.text :skills
  		t.text :achievements
  		t.integer :year_of_passing
  		t.integer :year_of_study
  		t.integer :phone_no
  		t.integer :percentage
  	end

  	create_table :educations do |t|
  		t.references :student, index: true
  		t.string :degree
  		t.string :institute
  		t.integer :percentage
  		t.integer :year_of_passing
  	end

  	create_table :experiences do |t|
  		t.references :student, index: true
  		t.string :company_name
  		t.string :position
  		t.text :contributions
  		t.date :start_date
  		t.date :end_date
  	end

  	create_table :projects do |t|
  		t.references :student, index: true
  		t.string :name
  		t.text :description 
  	end

  end
end
