class Address < ActiveRecord::Base
	acts_as_paranoid
	include Verifiable

	belongs_to :account

	validates :account_id, presence: true
	validate :account_exists # verify existence of the account this address references

	validates :label, 	presence: true
	validates :street1, presence: true
	validates :city, 		presence: true
	validates :state, 	presence: true
	validates :zip, 		presence: true
	validates :source, 	presence: true

	# TODO: refactor the "default_value_for :source" into a concern
  default_value_for :source do # see gem 'default_value_for'
    "appsyn"  # TODO: make this a user email
  end

	validates_format_of :zip, with: /\A\d{5}(-\d{4})?\z/, 
														message: "should be in the form 12345 or 12345-1234"
  validates_format_of :state, with: /\A[A-Za-z]{2}\z/
	# validates :state, presence: true, inclusion: { in: Carmen.state_codes }  <-- TODO: not sure why this doesn't work

end
