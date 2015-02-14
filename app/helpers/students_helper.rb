module StudentsHelper
	def account_settings
		@student = current_user
		@current_students_tpo = Tpo.find_by(college_id: current_user.college_id)
	end

	def my_applications
		student = Student.find(params[:id])
		@applications = student.job_applications
	end
end
