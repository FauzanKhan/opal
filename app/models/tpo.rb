class Tpo < ActiveRecord::Base
	
	#self.primary_key = 'email'

	attr_accessor :remember_token

	before_save { self.email = email.downcase }
	
	before_save :update_all_users_table
	
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

	def Tpo.digest(string)
	    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
	                                                  BCrypt::Engine.cost
	    BCrypt::Password.create(string, cost: cost)
	end

	def Tpo.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = Tpo.new_token
    	update_column(:remember_digest, Tpo.digest(remember_token))
	end

	# Forgets a user.
	def forget
		update_column(:remember_digest, nil)
	end

	# Returns true if the given token matches the digest.
	def authenticated?(remember_token)
		return false if remember_digest.nil?
    	BCrypt::Password.new(remember_digest).is_password?(remember_token)
  	end

    private

        def update_all_users_table
            new_user = AllUser.new
            new_user.email = self.email
            new_user.name = self.name
            new_user.college = self.college
            new_user.user_type = "tpo"
            errors.add(:email, "is already taken") if !new_user.save
            new_user.save
        end
end
