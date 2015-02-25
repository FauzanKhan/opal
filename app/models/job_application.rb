class JobApplication < ActiveRecord::Base
	belongs_to :student
	belongs_to :jobpost
end
