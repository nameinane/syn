require 'spec_helper'

describe Person do
  
  before :each do
    @person = FactoryGirl.create(:person)
  end

  subject { @person }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name)  }

  it { should belong_to(:account)     }
  it { should have_many(:yizkors)     }
  it { should have_one(:sponsor)      }
  it { should have_many(:mentions)    }

  it { should validate_presence_of(:account_id) }
  it { should validate_presence_of(:sort_order) }
  it { should validate_presence_of(:source)     }

  it { should be_valid }

  it { should_not allow_value(999999).for(:sort_order)  }
	it { should allow_value(2000).for(:sort_order)  }
	it { should allow_value("faker").for(:source)        }

end