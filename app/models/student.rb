class Student < ActiveRecord::Base
	
	attr_accessor :remember_token, :reset_token, :activation_token
	
	before_save { self.email = email.downcase }
	
	before_create :update_all_users_table
	
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

	# Returns the hash digest of the given string.
	def Student.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end

  	# generates a random token
  	def Student.new_token
		SecureRandom.urlsafe_base64  		
  	end

  	# Remembers a user in the database for use in persistent sessions.
	def remember
    	self.remember_token = Student.new_token
    	update_column(:remember_digest, Student.digest(remember_token))
  	end

  	def authenticated?(attribute, token)
  		digest = self.send("#{attribute}_digest")
  		return false if digest.nil?
    	BCrypt::Password.new(digest).is_password?(token)
  	end

  	  # Forgets a user.
	def forget
		update_column(:remember_digest, nil)
	end

    private

        def update_all_users_table
            new_user = AllUser.new
            new_user.email = self.email
            new_user.name = self.name
            new_user.college = self.college
            new_user.user_type = "student"
            errors.add(:email, "is already taken") if !new_user.save
            new_user.save
        end

end
