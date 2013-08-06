require 'spec_helper'

describe Account do
  
  before :each do
    @account = FactoryGirl.create(:account)
  end

  subject { @account }

  it { should respond_to(:tag)              }
  it { should respond_to(:name)             }
  it { should have_many(:people)            }
  it { should have_one(:address)            }
  it { should have_many(:mentions)          }
  it { should have_many(:payments)          }
  it { should validate_presence_of(:name)   }
  it { should validate_presence_of(:tag)    }
  it { should validate_uniqueness_of(:tag)  }

  it { should be_valid }

  describe ":: when tag is not present, it" do
    before { @account.tag = " " }
    it { should_not be_valid }
  end

  describe ":: when name is not present, it" do
    before { @account.name = " " }
    it { should_not be_valid }
  end

  describe ":: when account with this tag already exists, " do
    let (:account_twin)  { @account.dup }
    specify { account_twin.should_not be_valid }      

    describe "but in different case, it still" do
      before do
        account_twin.tag = @account.tag.downcase
      end
      specify { account_twin.should_not be_valid }      
    end
  end


end