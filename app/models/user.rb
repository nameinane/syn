class User < ActiveRecord::Base
	acts_as_paranoid
	default_scope -> { order('created_at DESC') }
	before_save { self.email = email.downcase }
	before_create :create_remember_token

	has_secure_password
	
	validates :email, presence: true, format: { with: /.+@.+\..+/i },
										uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }



	def User.new_remember_token
		SecureRandom.urlsafe_base64		
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	# TODO: fix search to disregard case
	def User.search(search)
	  if search
	    #find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
	    #WHERE (name LIKE '%Fr%')
	    where("name LIKE ?", "%#{search}%") 
	  else
	    all
	  end
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end

end
