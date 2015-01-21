class Jobpost < ActiveRecord::Base
	belongs_to :tpo
	default_scope -> { order(created_at: :desc) }
	validates :tpo_id, presence: true
	#validates :location, presence: true
	validates :company, presence: true
	validates :position, presence: true
end
