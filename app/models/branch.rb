class Branch < ActiveRecord::Base
	belongs_to :course
	has_many :eligible_branches
	has_many :jobposts, through: :eligible_branches
end
