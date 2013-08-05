module Verifiable
  extend ActiveSupport::Concern

  ### SYNAGOGUE-SPECIFIC FUNCTIONS BELOW ###

  # Verifies that an account with particular account_id exists
  # TODO: refactor this -- a better method or gem must exist (although validate_existence doesn't seem to work)
  def account_exists
    # Validation will pass if the account exists
    valid = Account.exists?(self.account_id)
    self.errors.add(:account, "doesn't exist.") unless valid		
	end

  # Verifies that a mentionable with (passed-in) particular account_id or person_id exists
  # TODO: refactor this -- a better method or gem must exist (although validate_existence doesn't seem to work)
  def mentionable_exists
    # Validation will pass if the account or peson exist
    case self.mentionable_type
    when "Account"
    	valid = Account.exists?(self.mentionable_id)
    when "Person"
    	valid = Person.exists?(self.mentionable_id)
    else
    	valid = false
    end
    self.errors.add(:mentionable, "doesn't exist.") unless valid
	end

  # verifies that both people in a relationship exist 
  # TODO: refactor, perhaps using a foreigner gem: https://github.com/matthuhiggins/foreigner
  def people_exist_on_the_same_account
    # Validation will pass if both people exist
    valid = Person.exists?(self.sponsor_id) && 
            Person.exists?(self.yizkor_id) && 
            Person.find(self.sponsor_id).account == Person.find(self.yizkor_id).account &&
            self.sponsor_id != self.yizkor_id
    self.errors.add(:relationship, "is invalid.") unless valid    
  end

end