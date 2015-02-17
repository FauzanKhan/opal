class Student < ActiveRecord::Base
	
	attr_accessor :remember_token, :reset_token, :activation_token, :image
	
  has_many :experiences, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :job_applications
  has_many :jobposts, through: :applications
  has_one :social_profile, dependent: :destroy
  accepts_nested_attributes_for :social_profile, allow_destroy: true

  accepts_nested_attributes_for :educations, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :experiences, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :projects, reject_if: :all_blank, allow_destroy: true

  mount_uploader :image, ImageUploader

	before_save { self.email = email.downcase }

  before_save { self.first_name = first_name.titleize }

  before_save { self.last_name = last_name.titleize }
	
	before_create :update_all_users_table

  before_create :create_activation_digest
	
	validates :email, 
			   presence: true,
			   length: {minimum: 5},
			   format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
			   uniqueness: {case_sensitive: false}

	 validates :first_name, 
         presence: true,
         length: {minimum: 3, maximum: 15}

	validates :college_id, presence: true, numericality: true

	validates :branch_id, presence: true, numericality: true

  validates :percentage, presence: true, numericality: true, on: :update

  validates :year_of_passing, presence: true, numericality: true, on: :update

	has_secure_password

	validates :password, length: {minimum: 6}, allow_blank: true

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

  def self.search_applicants(search, jobpost_id)
    where("first_name LIKE?", "%#{search}%") |
    where("last_name LIKE?", "%#{search}%") |
    where("email LIKE?", '%#{search}%' ) 
  end

    private

      def create_activation_digest
          self.activation_token = Student.new_token
          self.activation_digest = Student.digest(activation_token)
      end

        def update_all_users_table
            new_user = AllUser.new
            new_user.email = self.email
            new_user.first_name = self.first_name
            new_user.last_name = self.last_name
            new_user.college = self.college_id
            new_user.user_type = 2
            errors.add(:email, "is already taken") if !new_user.save
            new_user.save
        end

end
