class User < ActiveRecord::Base
	before_save { self.email = email.downcase }

	has_secure_password
	
	validates :email, presence: true, format: { with: /.+@.+\..+/i },
										uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }


end
