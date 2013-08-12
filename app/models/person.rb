class Person < ActiveRecord::Base
	acts_as_paranoid
	include Verifiable

	belongs_to :account

	has_many :mentions, as: :mentionable, dependent: :destroy

	has_many :relationships, foreign_key: "sponsor_id", dependent: :destroy
	has_many :yizkors, through: :relationships, source: :yizkor

	has_one :reverse_relationships, foreign_key: "yizkor_id", class_name: "Relationship", dependent: :destroy
	has_one :sponsor, through: :reverse_relationships, source: :sponsor


	accepts_nested_attributes_for :sponsor
	accepts_nested_attributes_for :yizkors
	accepts_nested_attributes_for :relationships



	validates :account_id, presence: true
	validate :account_exists # verify existence of the account of which this person is a part

	# TODO: validate that first_name and last_name are not null / blank?
	validates :sort_order, 	presence: true, numericality: true,
            format: { with: /\A\d{1,5}\z/ }

  default_value_for :sort_order do # see gem 'default_value_for'
    100
  end

  validates :source, presence: true
  default_value_for :source do # see gem 'default_value_for'
    "appsyn"  # TODO: make this a user email
  end



	def yizkor?
		Person.yizkors.include?(self)
	end

	def sponsor?
		Person.sponsors.include?(self)
	end

	def mentioned_in?(year) 
		mentions.map(&:years).include?(year)
	end


	def Person.yizkors
		where("id IN (#{yizkor_ids})")
	end

	def Person.sponsors
		where("id IN (#{sponsor_ids})")
	end



	# private helpers (made private explicitely by "private_class_method" at the bottom)
	def Person.yizkor_ids
		"SELECT yizkor_id FROM relationships"
	end

	def Person.sponsor_ids
		"SELECT sponsor_id FROM relationships"
	end
	private_class_method :yizkor_ids, :sponsor_ids


end
