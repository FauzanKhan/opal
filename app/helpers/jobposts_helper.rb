module JobpostsHelper
	def view_applications
		@jobpost = Jobpost.find(params[:id])
		@applications = @jobpost.job_applications
	end
end
