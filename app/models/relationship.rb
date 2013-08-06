class Relationship < ActiveRecord::Base
	acts_as_paranoid
	include Verifiable

	belongs_to :yizkor, class_name: "Person"
	belongs_to :sponsor, class_name: "Person"

	validate :people_exist_on_the_same_account # verify existence of both people in this relationship

	validates_uniqueness_of :yizkor_id
	validates_uniqueness_of :sponsor_id, scope: [:yizkor_id]

	# TODO: perhaps validate that a yizkor cannot be a sponsor?  not sure if this is true for all time though.

  default_value_for :source do # see gem 'default_value_for'
    "appsyn"  # TODO: make this a user email
  end

end
