class Jobpost < ActiveRecord::Base

	default_scope -> { order(created_at: :desc) }

	belongs_to :tpo

	has_many :eligible_courses
	has_many :courses, through: :eligible_courses

	has_many :eligible_branches
	has_many :branches, through: :eligible_branches

	validates :tpo_id, presence: true

	validates :location_id, presence: true

	validates :company, presence: true

	validates :position, presence: true

	before_save {self.last_date = last_date.to_date}

	before_save {self.drive_date = drive_date.to_date} 
end
