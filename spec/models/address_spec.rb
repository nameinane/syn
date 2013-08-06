require 'spec_helper'

describe Address do
  
  before :each do
    @address = FactoryGirl.create(:address, account: FactoryGirl.create(:account))
  end

  subject { @address }

  it { should respond_to(:label)              	}
  it { should respond_to(:street1)             	}
  it { should respond_to(:street2)             	}
  it { should respond_to(:city)             		}
  it { should respond_to(:state)             		}
  it { should respond_to(:zip)             			}
  it { should respond_to(:source)             	}

  it { should belong_to(:account)            		}

  it { should validate_presence_of(:account_id)	}
  it { should validate_presence_of(:street1)		}
  it { should validate_presence_of(:city)				}
  it { should validate_presence_of(:state)			}
  it { should validate_presence_of(:zip)				}
  it { should validate_presence_of(:source)			}

  it { should be_valid }

	it { should_not allow_value("blah").for(:zip) 	}
	it { should_not allow_value("12345-").for(:zip) }
	it { should allow_value("12345").for(:zip) 			}
	it { should allow_value("12345-1234").for(:zip) }

	it { should_not allow_value("MASS").for(:state) 	}
	it { should_not allow_value("G2").for(:state) 		}
	it { should allow_value("MA").for(:state) 				}

end