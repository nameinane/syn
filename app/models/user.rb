class User < ActiveRecord::Base

validates :email, presence: true, format: { with: /.+@.+\..+/i }


end
