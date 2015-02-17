class CoursesController < ApplicationController

	before_action :admin_user

	def index
		@courses = Course.all
	end

	def new
		@course = Course.new
		@branch = @course.branches.build
	end

	def create
		@course = Course.new(course_params)
		#@branch = @course.branches.build
		if @course.save
			flash[:success] = "Course successfully added"
			redirect_to courses_path
		end
	end

	def edit
		@course = Course.find(params[:id])
		@branch = @course.branches.build
	end

	def update
		@course = Course.find(params[:id])
		if @course.update_attributes(course_params)
			redirect_to courses_path
			flash[:success] = "Course successfully updated"
		else
			render 'edit'
		end
	end

	def destroy
		Course.find(params[:id]).destroy
		flash[:success] = "Course successfullly deleted"
		redirect_to courses_path
	end

	private

		def course_params
			params.require(:course).permit(:name, :branches_attributes => [:id, :name, :_destroy])
		end
end
