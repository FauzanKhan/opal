class Student < ActiveRecord::Base
	
	attr_accessor :remember_token, :reset_token, :activation_token
	
	before_save { self.email = email.downcase }
	
	before_create :update_all_users_table

  before_create :create_activation_digest
	
	validates :email, 
			   presence: true,
			   length: {minimum: 5},
			   format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
			   uniqueness: {case_sensitive: false}

	validates :name,
			   presence: true,
			   length: {minimum: 3}

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

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = Student.new_token
    update_attribute(:reset_digest,  Student.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  	  # Forgets a user.
	def forget
		update_column(:remember_digest, nil)
	end

    private

      def create_activation_digest
          self.activation_token = Student.new_token
          self.activation_digest = Student.digest(activation_token)
      end

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
