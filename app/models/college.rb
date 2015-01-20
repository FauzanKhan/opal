class College < ActiveRecord::Base
	before_save 
	validates :college_name, presence:true,
			 length:{minimum: 4},
			 uniqueness: { case_sensitive: false }
end
