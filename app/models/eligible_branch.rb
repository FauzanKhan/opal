class EligibleBranch < ActiveRecord::Base
	belongs_to :jobpost
	belongs_to :branch
end
