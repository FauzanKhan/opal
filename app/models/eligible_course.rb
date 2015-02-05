class EligibleCourse < ActiveRecord::Base
	belongs_to :jobpost
	belongs_to :course
end