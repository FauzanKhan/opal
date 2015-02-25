module StudentsHelper

	def account_settings
		@student = current_user
		@current_students_tpo = Tpo.find_by(college_id: current_user.college_id)
		@current_students_tpo = Tpo.find_by(college_id: current_user.college_id)
	end

	def my_applications
		student = Student.find(params[:id])
		@applications = student.job_applications.order(id: :desc)
	end

	def job_feed
		@student = current_user
		@current_students_tpo = Tpo.find_by(college_id: current_user.college_id)
		if params[:search]
	    	@jobposts = Jobpost.search(params[:search].gsub(/\s+/, ' ').strip)
	    elsif params[:location_id]
	    		@jobposts = Jobpost.where(location_id: params[:location_id])
	  	else
			job_type = params[:job_type]
			case job_type
				when '1'
					@jobposts = Jobpost.where(job_type: 1)
				when '2'
					@jobposts = Jobpost.where(job_type: 2)
				when '3'
					@jobposts = Jobpost.where(job_type: 3)
				when '4'
					@jobposts = Jobpost.where(job_type: 4)
				else
					@jobposts = Jobpost.all
			end
		end
		@jobposts = [] if @jobposts.nil?
		@jobposts = @jobposts.page(params[:page]).per(50)
	end
end
