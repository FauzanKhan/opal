class AllUser < ActiveRecord::Base
    
    before_save { self.email = email.downcase }
	
	validates :email, 
               presence: true,
               length: {minimum: 5}, 
               format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
               uniqueness: { case_sensitive: false }

    validates :first_name, 
			   presence: true,
			   length: {minimum: 3, maximum: 15}
			   
end
