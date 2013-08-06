require 'spec_helper'

describe Relationship do
  
  # before :each do
  #   @relationship = FactoryGirl.create(:relationship)
  # end

  let(:account)       { FactoryGirl.create(:account)                      }
  let(:yizkor)        { FactoryGirl.create(:yizkor, account: account)     }
  let(:sponsor)       { FactoryGirl.create(:sponsor, account: account)    }
  let(:relationship)  { sponsor.relationships.build(yizkor_id: yizkor.id) }

  subject { relationship}

  it { should be_valid  }

  it { should respond_to(:yizkor)   }
  it { should respond_to(:sponsor)  }
  it { should respond_to(:source)   }

  it { should belong_to(:yizkor)    }
  it { should belong_to(:sponsor)   }

  it { should validate_uniqueness_of(:yizkor_id)                        }
  it { should validate_uniqueness_of(:sponsor_id).scoped_to(:yizkor_id) }

  describe "should not allow ids that do not belong to existing people" do
    before { relationship.yizkor_id = 0 }
    it { should_not be_valid }
  end

  # TODO: there need to be tests here that ensure all relationships are 
  #       between appropriate parties (i.e. both people exist, and a person cannot be 
  #       a sponsor and a yizkor at the same time)

end