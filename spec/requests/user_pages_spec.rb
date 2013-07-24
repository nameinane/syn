require 'spec_helper'

describe "UserPages" do

  subject { page }

	describe "signup page" do
		before { visit signup_path }
    let(:submit) { "Create my account" }

		describe "title and content quick check" do
			it {should have_content('Confirmation') }
			it {should have_title(full_title('Sign Up')) }
		end

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Email",        with: "nameinane@gmail.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end


  describe "profile page" do
    let(:u) { FactoryGirl.create(:user) }
    before { visit user_path(u) }

    it { should have_content(u.email) }
    it { should have_title(u.email) }
    # binding.pry

  end

end
