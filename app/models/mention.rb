class Mention < ActiveRecord::Base
	acts_as_paranoid
	include Verifiable

	belongs_to :mentionable, polymorphic: true

	validates :mentionable_id, 		presence: true
	validates :mentionable_type, 	presence: true
	validate :mentionable_exists # verify existence of the person or account to be mentioned

	validates_uniqueness_of :mentionable_id, scope: [:mentionable_type, :year]

	validates :year, presence: true, numericality: { greater_than: 0 }
	default_value_for :year do # see gem 'default_value_for'
		Date.current.year  # TODO: maybe replace with Time.new.year (it's faster: http://eclecticquill.com/2013/01/04/current-year-in-ruby-on-rails/)
	end

	validates :source, presence: true
	# TODO: refactor the "default_value_for :source" into a concern
  default_value_for :source do # see gem 'default_value_for'
    "appsyn"  # TODO: make this a user email
  end

  def years
  	return year
  end


end
