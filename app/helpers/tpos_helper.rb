module TposHelper

	def admin_panel

	end

	def update_student_colleges(college_id)
		other_college_id = College.find_by(college_name: 'Other')
		effected_students = Student.where(college_id: college_id)
		effected_students.each do |e|
			e.update_attribute(:college_id, other_college_id)
		end
	end
end
