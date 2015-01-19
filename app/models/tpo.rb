class Tpo < ActiveRecord::Base
	
	#self.primary_key = 'email'

	attr_accessor :remember_token, :activation_token, :reset_token

	before_save { self.email = email.downcase }
	
	before_create :update_all_users_table

	before_create :create_activation_digest
	
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

	validates :password, length: {minimum: 6}, allow_blank: true

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
	def authenticated?(attribute, token)
		digest = self.send("#{attribute}_digest")
		return false if digest.nil?
    	BCrypt::Password.new(digest).is_password?(token)
  	end

  	def activate
  		update_attribute(:activated, true)
  		update_attribute(:activated_at, Time.zone.now)
  	end

  	def send_activation_email
  		UserMailer.account_activation(self).deliver_now
  	end

  	def create_reset_digest
  		self.reset_token = Tpo.new_token
  		update_attribute(:reset_digest,  Tpo.digest(reset_token))
    	update_attribute(:reset_sent_at, Time.zone.now)
  	end

  	def send_password_reset_email
  		UserMailer.password_reset(self).deliver_now
  	end

  # Returns true if a password reset has expired.
	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

    private

    	def create_activation_digest
    		self.activation_token = Tpo.new_token
    		self.activation_digest = Tpo.digest(activation_token)
    	end

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
