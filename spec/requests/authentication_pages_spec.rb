require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe "signin page and signout" do
		before { visit signin_path }

		it { should have_content "Sign in" }
		it { should have_title "Sign in" }

    describe "signin with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'wrong') }

			describe "error notice stays only for one page" do
			  before { click_link "Home" }
			  it { should_not have_selector('div.alert.alert-error') }
			end

    end


	  describe "signin with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_title(user.name) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "signout after signin" do
        before { click_link "Sign out"}
        it { should have_link('Sign in') }
        it { should_not have_link('Sign out') }
      end
    end


	end





end
