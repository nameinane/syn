class Payment < ActiveRecord::Base
	acts_as_paranoid
	include Verifiable

	belongs_to :account

	validates :account_id, presence: true
	validate :account_exists # verify existence of the account this payment references

	validates :amount, 	presence: true, numericality: { greater_than: 0 },
            format: { with: /\A\d{1,6}(\.\d{0,2})?\z/ }
	
	validates_date :paid_on, on_or_before: :today # see gem 'validates_timeliness'
	default_value_for :paid_on do # see gem 'default_value_for'
		Date.today
	end

	# TODO: refactor the "default_value_for :source" into a concern
  default_value_for :source do # see gem 'default_value_for'
    "appsyn"  # TODO: make this a user email
  end

  # TODO: currently there is no support for a present-day payment
  # 			covering a past-year or later-year inclusion in report (perhaps worthwhile?)

end
