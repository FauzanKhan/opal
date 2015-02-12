class Education < ActiveRecord::Base
	
	belongs_to :student

	before_save { self.institute = institute.titleize }

	before_save { self.degree = degree.titleize }

	validates :institute, presence: true

	validates :degree, presence: true

	validates :percentage, numericality: true

	validates :year_of_passing, presence:true, numericality: true

end