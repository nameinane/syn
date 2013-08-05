class Person < ActiveRecord::Base
	acts_as_paranoid

	belongs_to :account

	has_many :mentions, as: :mentionable, dependent: :destroy

	has_many :relationships, foreign_key: "sponsor_id", dependent: :destroy
	has_many :yizkors, through: :relationships, source: :yizkor

	has_one :reverse_relationships, foreign_key: "yizkor_id", class_name: "Relationship", dependent: :destroy
	has_one :sponsor, through: :reverse_relationships, source: :sponsor

	validates :account_id, presence: true
	validate :account_exists # verify existence of the account of which this person is a part

	validates :sort_order, 	presence: true, numericality: true,
            format: { with: /\A\d{1,4}\z/ }

	validates_inclusion_of :active, in: [true, false]


	def yizkor?
		Person.yizkors.include?(self)
	end

	def sponsor?
		Person.sponsors.include?(self)
	end

	def self.yizkors
		where("id IN (#{yizkor_ids})")
	end

	def self.sponsors
		where("id IN (#{sponsor_ids})")
	end


	# private helpers (made private explicitely by "private_class_method" at the bottom)
	def self.yizkor_ids
		"SELECT yizkor_id FROM relationships"
	end

	def self.sponsor_ids
		"SELECT sponsor_id FROM relationships"
	end
	private_class_method :yizkor_ids, :sponsor_ids

end
