class Course < ActiveRecord::Base
	has_many :branches, dependent: :destroy
	has_many :eligible_courses
	has_many :jobposts, through: :eligible_courses
end
