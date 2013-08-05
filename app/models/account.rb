class Account < ActiveRecord::Base
	acts_as_paranoid

	has_many :people, dependent: :destroy
	has_many :payments, dependent: :destroy
	has_many :addresses, dependent: :destroy
	has_many :mentions, as: :mentionable, dependent: :destroy


	validates :tag, presence: true, uniqueness: { case_sensitive: false }
	validates :name, presence: true
	validates_inclusion_of :active, in: [true, false]

	def address
		self.addresses.where(active: true)
	end


end
