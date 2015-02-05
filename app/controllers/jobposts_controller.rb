class JobpostsController < ApplicationController
	#before_action :logged_in_user, [only: :new, :create, :destroy, :edit]
	
	def new
		@tpo = current_user
		@jobpost = Jobpost.new
		@courses = Course.all
		@branches = Branch.all
		@jobpost.eligible_courses.each do |c|
	      c.eligible_branch.build
	  end
	end

	def create
		@tpo = current_user
		@jobpost = current_user.jobposts.build(jobpost_params)
		if @jobpost.save
			flash[:success] = "Job Posted Successfully"
			redirect_to current_user
		else
			render 'new'
		end
	end

	def show
		current_user.user_type == 2 ? @student = current_user : @tpo = current_user
		@jobpost = Jobpost.find(params[:id])
		job = Jobpost.find(params[:id])
		if current_user.user_type == 2
			@current_students_tpo = Tpo.find_by(college_id: current_user.college_id)
		end
	end

	def edit
		@tpo = current_user
		@courses = Course.all
		@branches = Branch.all
		@jobpost = Jobpost.find(params[:id])
	end

	def update
		@jobpost = Jobpost.find(params[:id])
		#old_email = @tpo.email
		#new_email = params[:tpo][:email]
		#update_all_user(old_email, new_email)
		if @jobpost.update_attributes(jobpost_params)
			flash[:success] = "Job Post Updated"
      		redirect_to current_user
		else
			render 'edit'
		end
	end

	def destroy

	end

	def populate_branches
		@branches = Branch.where(course_id: params[:course_id])
		respond_to do |format|
			format.js
		end
	end

	private
		def jobpost_params
			params.require(:jobpost).permit(:company, :position, :percentage_required, :required_brach,:other_requirements,  
											:job_profile, :location, :venue, :location_id, :job_type, :instructions, 
											:about_company, :last_date, :drive_date, :course_ids => [], :branch_ids => [])
		end

end
