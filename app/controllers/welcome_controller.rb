class WelcomeController < ApplicationController

	def index
		if current_user.user_type == 1 
			redirect_to current_user
		elsif current_user.user_type == 2
			redirect_to jobfeed_student_path
		end
	end
	
end
