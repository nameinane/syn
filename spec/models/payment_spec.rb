require 'spec_helper'

describe Payment do
  
  before :each do
    @payment = FactoryGirl.create(:payment, account: FactoryGirl.create(:account))
  end

  subject { @payment }

  it { should respond_to(:amount)  }
  it { should respond_to(:paid_on) }

  it { should belong_to(:account)  }

  it { should validate_presence_of(:account_id) }
  # TODO: the timeliness gem is for some reason not available here:
  # it { should validate_date(:paid_on)    }
  # it should be, it would be good to have access to its date validation methods in rspec

  it { should be_valid }

  it { should_not allow_value(0).for(:amount)   }
  it { should_not allow_value(-1).for(:amount)     }
  it { should allow_value(18).for(:amount)         }
  it { should allow_value(9999).for(:amount)         }

  it { should_not allow_value(1.day.from_now).for(:paid_on) }
  it { should_not allow_value("1/1/11111").for(:paid_on)    }
  it { should allow_value(1.day.ago).for(:paid_on)          }
  it { should allow_value(Date.today).for(:paid_on)         }


end