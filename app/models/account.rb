class Account < ActiveRecord::Base
	acts_as_paranoid

	has_many :people, dependent: :destroy
	has_one	 :address, dependent: :destroy
	has_many :payments, dependent: :destroy
	has_many :mentions, as: :mentionable, dependent: :destroy


	validates :tag, presence: true, uniqueness: { case_sensitive: false }
	validates :name, presence: true

end
