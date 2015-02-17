class JobpostUpdate < ApplicationMailer

	def new_job_posted(jobpost)
		#@jobpost = jobpost
		job_author_id = jobpost.tpo_id
		eligible_courses = jobpost.courses.ids
		eligible_branches = jobpost.branches.ids
		eligible_percentage = jobpost.percentage_required
		college_id = Tpo.find(job_author_id).college_id
		college_students = Student.where(college_id: college_id)
		eligible_students = Array.new
		college_students.each do |student|
			if student.percentage && student.percentage >= eligible_percentage && eligible_courses.include?(student.course_id) && eligible_branches.include?(student.branch_id)
				#@student_name = student.first_name
				#mail to: student.email, subject: "Your Tpo Posted a new Job"
				send_mail(student, jobpost).deliver
			end
		end
	end

	def application_update(jobpost, applicant_id, status)
		@status = status
		@applicant = Student.find(applicant_id)
		@jobpost = jobpost
		mail to: @applicant.email, subject: "Update on your application - "+@jobpost.position+" at "+@jobpost.company
	end
	#we have to call mail to: action from another method while sending mails to multiple reciepients in a single request
	def send_mail(reciepient, jobpost)
		@jobpost = jobpost
		@student_name = reciepient.first_name
		mail to: reciepient.email, subject: "Your Tpo Posted a new Job"
	end

end
