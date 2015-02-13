class JobApplicationsController < ApplicationController
	def create
		jobpost_id = params[:jobpost_id]
		student_id = current_user.id
		application = JobApplication.new(jobpost_id: jobpost_id, student_id: current_user.id)
		if current_user.user_type == 2 && application.save
			redirect_to root_path
			flash[:success] = "Your application has been posted successfully"
		else
			redirect_to :back
			flash[:danger] = "You cannot apply to this jobpost"
		end
	end
end