class LegacyAccounts < ActiveRecord::Base
	has_many :people, class_name: 'LegacyPeople', primary_key: :account_tag, foreign_key: :account_tag
	has_many :addresses, class_name: 'LegacyAddresses', primary_key: :account_tag, foreign_key: :account_tag
	has_many :payments, class_name: 'LegacyPayments', primary_key: :account_tag, foreign_key: :account_tag
	has_many :mentions, -> { where publication_type: "holocaust" }, class_name: 'LegacyMentions', 
						primary_key: :account_tag, foreign_key: :account_tag
end

class LegacyAddresses < ActiveRecord::Base
  belongs_to :account, class_name: 'LegacyAccounts', primary_key: :account_tag, foreign_key: :account_tag
end

class LegacyMentions < ActiveRecord::Base

	def self.years
		pluck(:publication_year).uniq
	end

end

class LegacyPayments < ActiveRecord::Base
  belongs_to :account, class_name: 'LegacyAccounts', primary_key: :account_tag, foreign_key: :account_tag
end

class LegacyPeople < ActiveRecord::Base
  belongs_to :account, class_name: 'LegacyAccounts', primary_key: :account_tag, foreign_key: :account_tag
	has_many :mentions, -> { where publication_type: "book" }, class_name: 'LegacyMentions', 
						primary_key: :account_tag, foreign_key: :account_tag

	def self.sponsors
		pluck(:sponsor_first_name, :sponsor_last_name).uniq
	end

	def self.yizkors
		pluck(:yizkor_first_name, :yizkor_last_name).uniq
	end

end