class Account < ActiveRecord::Base
	acts_as_paranoid

	has_one	 :address, dependent: :destroy
	has_many :payments, dependent: :destroy
	has_many :mentions, as: :mentionable, dependent: :destroy

	has_many :relationships
	has_many :sponsors, -> { uniq }, through: :relationships
	has_many :yizkors, -> { uniq }, through: :relationships

	has_many :people, dependent: :destroy
	# has_many :yizkors, -> { uniq }, through: :sponsors
	# has_many :relationships, through: :people
	# has_many :yizkors, -> { uniq }, through: :people

	accepts_nested_attributes_for :address
	accepts_nested_attributes_for :relationships
	# accepts_nested_attributes_for :sponsors
	# accepts_nested_attributes_for :yizkors
	accepts_nested_attributes_for :people, allow_destroy: true
	accepts_nested_attributes_for :mentions, allow_destroy: true

	validates :tag, presence: true, uniqueness: { case_sensitive: false, scope: [:deleted_at] }
	validates :name, presence: true


	def publication_history
		history = ""
		book_years = self.mentions.pluck(:year).uniq
		
		history << "Account #{self.tag}::#{self.name} mentioned in: #{book_years.to_s}"
		self.people.each do |person|
			person_full_name = "#{person.first_name} #{person.last_name}"
			holocaust_years = person.mentions.pluck(:year).uniq
			person_report = "#{person_full_name} mentioned in: #{holocaust_years.to_s}"
			history << person_report
		end

		history
	end

	# TODO: improve search to disregard case and to search associated records
	def Account.search(search)
	  if search
	    where("tag LIKE ? or name LIKE ?", "%#{search}%", "%#{search}%") 
	  else
	    all
	  end
	end

	def mentioned_in?(year) 
		mentions.map(&:years).include?(year)
	end

end
