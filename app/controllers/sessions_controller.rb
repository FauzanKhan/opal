class SessionsController < ApplicationController

	before_action :redirect_if_logged_in, only: [:new]

	def new
		
	end

	def create
		student = Student.find_by(email: params[:session][:email].downcase)
		tpo = Tpo.find_by(email: params[:session][:email].downcase)
		if student && student.authenticate(params[:session][:password])
			if student.activated?
				log_in student
				params[:session][:remember_me] == '1' ? remember(student) : forget(student)
				redirect_back_or root_path
			else
				flash[:danger] = "Account not activated. Check your email for activation link"
				redirect_to root_url
			end
		elsif tpo && tpo.authenticate(params[:session][:password])
			if tpo.activated?
				log_in tpo
				params[:session][:remember_me] == '1' ? remember(tpo) : forget(tpo)
				redirect_back_or root_path
			else
				flash[:danger] = "Account not activated. Check your email for activation link"
				redirect_to root_url
			end
		else
			flash.now[:danger] = "Invalid email/password combination"
			render 'new'
		end
	end

	def destroy
		log_out if logged_in?
		redirect_to root_path
	end
end
