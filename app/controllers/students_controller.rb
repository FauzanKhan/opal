class StudentsController < ApplicationController
	
	before_action :logged_in_user, only: [:edit, :update, :show]
    before_action :correct_user, only: [:edit, :update]
	
	def new
		@student = Student.new
	end

	def create
		@student = Student.new(student_params)
		@student.first_name = params[:student][:first_name].titleize
		@student.last_name = params[:student][:last_name].titleize
		@student.user_type = 'student'
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
		@current_students_tpo = Tpo.find_by(college: current_user.college)
	end

	private
		def student_params
			params.require(:student).permit(:email, :password, :first_name, :last_name, :college, :course, :branch)
		end

		def logged_in_user
			unless logged_in?
				store_url
				flash[:danger] = "Please LogIn to access this page"
				redirect_to new_session_path
			end
		end

		def correct_user
			@user = Student.find(params[:id])
			redirect_to root_path unless @user == current_user
		end

end
