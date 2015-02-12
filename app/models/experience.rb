class Experience < ActiveRecord::Base
	belongs_to :student

	before_save {self.company_name = company_name.titleize}

	validates :company_name, presence: true

	validates :position, presence: true

end