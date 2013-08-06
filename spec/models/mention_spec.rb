require 'spec_helper'

describe Mention do
  
  before :each do
    @mention = FactoryGirl.create(:mention)
  end

  subject { @mention }

  it { should respond_to(:year)   }
  it { should respond_to(:source) }

  it { should belong_to(:mentionable) }

  it { should validate_presence_of(:mentionable_id)		}
  it { should validate_presence_of(:mentionable_type)	}
  it { should validate_presence_of(:source)           }
  it { should validate_numericality_of(:year)					}

  # TODO: test uniqueness validation, currently, this way seems broken 
  # (https://github.com/thoughtbot/shoulda-matchers/issues/320):
  # it { should validate_uniqueness_of(:mentionable_id).scoped_to(:mentionable_type, :year) }
  # but it's no reason not to do it at all.

  it { should be_valid }

	it { should_not allow_value("blah").for(:year)	}
	it { should_not allow_value("-11").for(:year)		}
	it { should allow_value("2012").for(:year)			}

	it { should allow_value("faker").for(:source)		}

  # TODO: currently, no testing is done for mentionable accounts
  #       perhaps, it could be done like so: http://stackoverflow.com/questions/7747945/factorygirl-and-polymorphic-associations

end