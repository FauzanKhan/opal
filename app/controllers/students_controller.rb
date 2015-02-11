class StudentsController < ApplicationController
	
	before_action :logged_in_user, only: [:edit, :update, :show]
    before_action :correct_user, only: [:edit, :update, :account_settings]
    before_action :redirect_if_logged_in, only: [:new]
	
	def new
		@student = Student.new
		@courses = Course.all
		@branches = Branch.where(course_id: Course.first.id)
	end

	def create
		@student = Student.new(student_params)
		@student.first_name = params[:student][:first_name].titleize
		@student.last_name = params[:student][:last_name].titleize
		if @student.save
			#log_in @student
			@student.send_activation_email
			flash[:info] = "Please check your email to activate your account"
			redirect_to root_url 
		else
			render 'new'
		end
	end

	def show
		@student = Student.find(params[:id])
		@college = College.find(@student.college_id)
		@course = Course.find(@student.course_id)
		@branch = Branch.find(@student.branch_id)
		@current_students_tpo = Tpo.find_by(college_id: current_user.college_id)
	end

	def edit
		@student = current_user
		@branches = Branch.where(course_id: @student.course_id)
		@education = current_user.educations.build
		@existing_eduaction = Education.where(student_id: @student.id)
		#@education = Education.new
		@experience = current_user.experiences.build
		@project = Project.new
	end

	def update
		@student = current_user
		if @student.update_attributes(update_params)
			redirect_to current_user
			flash[:success] = "Profile successfully updated"
		else
			render 'edit'
		end
	end

	def account_settings
		@student = current_user
	end

	def update_account
		@student = Student.find(params[:id])
		if @student.update_attributes(account_params)
			flash[:success] = "Account updated Successfully"
			redirect_to current_user
		else
			render 'account_settings'
		end 
	end

	def populate_branches
		@branches = Branch.where(course_id: params[:course_id])
		respond_to do |format|
			format.js
		end 
	end

	private
		def student_params
			params.require(:student).permit(:email, :password, :first_name, :last_name, :college_id, :course_id, :branch_id)
		end

		def account_params
			params.require(:student).permit(:password)
		end

		def update_params
			params.require(:student).permit(:first_name, :last_name, :location_id, :college_id, :course_id, :image, :phone_no, 
											:skills, :achievements, :percentage, :year_of_study, :year_of_passing, 
											:educations_attributes => [:id, :institute, :degree, :percentage, :year_of_passing, :_destroy], 
											:experiences_attributes => [:id, :company_name, :position, :contributions, :start_date, :end_date, :_destroy],
											:projects_attributes => [:id, :name, :description, :_destroy])
		end

		def education_params 
			params.require(:education).permit(:institute, :degree, :percentage, :year_of_passing)
		end

		def correct_user
			@user = Student.find(params[:id])
			redirect_to root_path unless @user == current_user
		end

end
