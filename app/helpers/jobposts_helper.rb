module JobpostsHelper
	def view_applications
		@jobpost = Jobpost.find(params[:id])
		@applications = @jobpost.job_applications
	end

	def already_applied?
		jobpost = Jobpost.find(params[:id])
		job_applications = jobpost.job_applications
		student = current_user
		applied = job_applications.find_by(student_id: student.id)
		!applied.nil?
	end

	def can_apply?
		jobpost = Jobpost.find(params[:id])
		author = Tpo.find(jobpost.tpo_id)
		student = current_user
		if jobpost.job_type == 1 || jobpost.job_type == 4
			student.college_id == author.college_id
		else
			return true
		end
	end

	def job_expired?
		jobpost = Jobpost.find(params[:id])
		Date.today > jobpost.last_date
	end
end
