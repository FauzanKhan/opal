class Course < ActiveRecord::Base
	has_many :branches, dependent: :destroy
	has_many :eligible_courses
	has_many :jobposts, through: :eligible_courses

	accepts_nested_attributes_for :branches, reject_if: :all_blank, allow_destroy: true
end
