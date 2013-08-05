class Address < ActiveRecord::Base
	acts_as_paranoid
	include Verifiable

	belongs_to :account

	validates :account_id, presence: true
	validate :account_exists # verify existence of the account this payment references

	validates_inclusion_of :active, in: [true, false]
	validate :only_one_active_address_per_account

	validates_format_of :zip, with: /\A\d{5}(-\d{4})?\z/, 
														message: "should be in the form 12345 or 12345-1234"
  validates_format_of :state, with: /\A[A-Za-z]{2}\z/
	# validates :state, presence: true, inclusion: { in: Carmen.state_codes }  <-- TODO: not sure why this doesn't work

	def only_one_active_address_per_account
	  if active? and Address.exists? ["account_id = ? AND active = true AND id != ?", account_id, id.to_i]
	    errors.add( :account_id, 'already has an active address')
	  end
	end

end
