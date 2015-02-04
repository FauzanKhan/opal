class StudentsController < ApplicationController
	
	before_action :logged_in_user, only: [:edit, :update, :show]
    before_action :correct_user, only: [:edit, :update]
	
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

		def correct_user
			@user = Student.find(params[:id])
			redirect_to root_path unless @user == current_user
		end

end
