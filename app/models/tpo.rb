class Tpo < ActiveRecord::Base
	#self.primary_key = 'email'
	before_save { self.email = email.downcase }
	validates :email, 
			   presence: true,
			   length: {minimum: 5}, 
			   format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
			   uniqueness: { case_sensitive: false } #Note that we have simply replaced true with case_sensitive: false (Rails infers that uniqueness should be true as well.)

	validates :name, 
			   presence: true,
			   length: {minimum: 3}

	validates :college, presence: true

	has_secure_password

	validates :password, length: {minimum: 6}
end
