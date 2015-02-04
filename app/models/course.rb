class Course < ActiveRecord::Base
	has_many :branches, dependent: :destroy
end
