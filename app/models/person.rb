class Person < ActiveRecord::Base
	acts_as_paranoid
	include Verifiable


	has_many :mentions, as: :mentionable, dependent: :destroy

	has_many :relationships, foreign_key: "sponsor_id", dependent: :destroy
	has_many :yizkors, through: :relationships

	has_one :reverse_relationship, foreign_key: "yizkor_id", class_name: "Relationship", dependent: :destroy
	has_one :sponsor, through: :reverse_relationship

	belongs_to :account

	accepts_nested_attributes_for :sponsor
	accepts_nested_attributes_for :yizkors
	accepts_nested_attributes_for :relationships, allow_destroy: true
	accepts_nested_attributes_for :mentions, allow_destroy: true

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
		!sponsor.nil?
	end

	def sponsor?
		!yizkors.empty?
	end

	def mentioned_in?(year) 
		mentions.map(&:years).include?(year)
	end

	def mention_yizkor (yizkor_id, mention_year, relationship_kind, create_relationship)	  
		# binding.pry
		# TODO: dry this code
		if has_yizkor?(yizkor_id)
			# just create the mention
			begin
				Person.mention(yizkor_id, mention_year)
			rescue => e
				logger.error e.message
				false
			end
		elsif create_relationship
			# doesn't have this yizkor, but wants to create the relationship
			begin
				relationships.create(yizkor_id: yizkor_id, kind: relationship_kind, account_id: self.account_id)	
				Person.mention(yizkor_id, mention_year)
			rescue => e
				logger.error e.message
				false
			end
		else
			# this is an unrelated person and we aren't asked to create the relationship
			false
		end		

	end

	def has_yizkor?(yizkor_id)
		yizkors.map(&:id).include?(yizkor_id)
	end


	def Person.mention(yizkor_id, mention_year)
		self.find(yizkor_id).mentions.create(year: mention_year)
	end


	# def Person.yizkors
	# 	where("id IN (#{yizkor_ids})")
	# end

	# def Person.sponsors
	# 	where("id IN (#{sponsor_ids})")
	# end



	# private helpers (made private explicitely by "private_class_method" at the bottom)
	def Person.yizkor_ids
		"SELECT yizkor_id FROM relationships"
	end

	def Person.sponsor_ids
		"SELECT sponsor_id FROM relationships"
	end
	# private_class_method :yizkor_ids, :sponsor_ids


end
