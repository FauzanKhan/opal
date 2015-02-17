# Preview all emails at http://localhost:3000/rails/mailers/jobpost_update
class JobpostUpdatePreview < ActionMailer::Preview
	def new_job_posted
		jobpost = Jobpost.first
		JobpostUpdate.new_job_posted(jobpost)
	end

	def application_udate
		jobpost = Jobpost.first
		student = Student.first
		JobpostUpdate.application_update(student, jobpost, "selected")
	end
end
