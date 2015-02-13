class JobApplication < ActiveRecord::Base
	belongs_to :students
	belongs_to :jobposts
end
