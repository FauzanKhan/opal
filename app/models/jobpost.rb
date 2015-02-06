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

	#validates :eligible_courses, presence: true

	validates :venue, presence: true

	validates :last_date, presence: true

	validates :drive_date, presence: true

	validates_presence_of :courses

end
