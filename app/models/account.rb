class Account < ActiveRecord::Base
	acts_as_paranoid

	has_many :people, dependent: :destroy
	has_one	 :address, dependent: :destroy
	has_many :payments, dependent: :destroy
	has_many :mentions, as: :mentionable, dependent: :destroy


	validates :tag, presence: true, uniqueness: { case_sensitive: false, scope: [:deleted_at] }
	validates :name, presence: true

	def yizkors
		self.people.yizkors
	end

	def sponsors
		self.people.sponsors
	end

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



end
