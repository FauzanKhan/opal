class StudentsController < ApplicationController

	def new
		@student = Student.new

	end

	def create
		@student = Student.new(student_params)
		@student.name = params[:student][:name].titleize
		if @student.save
			flash[:success] = "Welcome to simplifica"
			redirect_to @student
		else
			render 'new'
		end
	end

	def show
		@student = Student.find(params[:id])
	end

	private
		def student_params
			params.require(:student).permit(:email, :password, :name, :college, :course, :branch)
		end

end
