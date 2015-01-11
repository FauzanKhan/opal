class SessionsController < ApplicationController

	def new
	end

	def create
		student = Student.find_by(email: params[:session][:email].downcase)
		tpo = Tpo.find_by(email: params[:session][:email].downcase)
		if student && student.authenticate(params[:session][:password])
			log_in student
			params[:session][:remember_me] == '1' ? remember(student) : forget(student)
			redirect_to student
		elsif tpo && tpo.authenticate(params[:session][:password])
			log_in tpo
			params[:session][:remember_me] == '1' ? remember(tpo) : forget(tpo)
			redirect_to tpo
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
