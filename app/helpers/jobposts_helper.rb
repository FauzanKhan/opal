module JobpostsHelper
	
	def search_applicants(search, jobpost)
		keywords = search.split
		students = Array.new
		keywords.each do |keyword|
			student_ids = Student.where("first_name = ? OR last_name = ? OR email = ?", keyword, keyword, keyword).ids
			students.push(student_ids).flatten!
		end
		jobpost.job_applications.where(student_id: students)
	end

	def view_applicants
		@jobpost = Jobpost.find(params[:id])
		@show_selected = params[:show_selected]
		@show_shortlisted = params[:show_shortlisted]
		if params[:search_applicant]
			#students = Student.search_applicants(params[:search], params[:id])
			@applications = search_applicants(params[:search_applicant], @jobpost) 
		elsif @show_selected
			@applications = @jobpost.job_applications.where(selected: true)
		elsif @show_shortlisted
			@applications = @jobpost.job_applications.where(shortlisted: 1)
		else
			@applications = @jobpost.job_applications
		end
		@applications = [] if @applications.nil?
	end

	def already_applied?
		jobpost = Jobpost.find(params[:id])
		student = current_user
		applied = JobApplication.find_by(student_id: student.id, jobpost_id: jobpost.id)
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

	def shortlist_applicant
		applicant_id = params[:applicant_id]
		jobpost_id = params[:jobpost_id]
		@jobpost = Jobpost.find(jobpost_id)
		job_application = JobApplication.find_by(student_id: applicant_id, jobpost_id: jobpost_id)
		shortlisted_for_round = job_application.shortlisted
		shortlisted_for_round += 1
		respond_to do |format|
			if job_application.update_attribute(:shortlisted, shortlisted_for_round)
				@jobpost.send_application_status_mailer(applicant_id, "shortlisted")
				format.html { render :nothing => true, :notice => 'Update SUCCESSFUL!' } 
			end
		end
	end

	def select_applicant
		applicant_id = params[:applicant_id]
		jobpost_id = params[:jobpost_id]
		@jobpost = Jobpost.find(jobpost_id)
		job_application = JobApplication.find_by(student_id: applicant_id, jobpost_id: jobpost_id)
		respond_to do |format|
			if job_application.update_attribute(:selected, true)
				@jobpost.send_application_status_mailer(applicant_id, "selected")
				format.html { render :nothing => true, :notice => 'Update SUCCESSFUL!' } 
			end
		end
	end
end
