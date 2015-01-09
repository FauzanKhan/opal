class Student < ActiveRecord::Base

	before_save { self.email = email.downcase }
	validates :email, 
			   presence: true,
			   length: {minimum: 5},
			   format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
			   uniqueness: {case_sensitive: false}

	validates :name,
			   presence: true,
			   length: {minimum: 5}

	validates :college, presence: true

	validates :branch, presence: true

	has_secure_password

	validates :password, length: {minimum: 6}

end
