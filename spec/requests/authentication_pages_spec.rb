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
      before { sign_in user }

      it { should have_title(user.name) }
      it { should have_link('Users',       href: users_path) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Settings',     href: edit_user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "signout after signin" do
        before { click_link "Sign out"}
        it { should have_link('Sign in') }
        it { should_not have_link('Sign out') }
      end
    end
	end

  describe "authorization" do
    describe "for non-signed in users" do
      let (:user) { FactoryGirl.create(:user) }

      describe "in the users controller" do
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email:'so@wrong.com') }

      before { sign_in(user, no_capybara: true) }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_title(full_title('Edit profile')) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end

    describe "for non-signed in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",        with: user.email
          fill_in "Password",     with: user.password
          click_button "Sign in"
        end

        describe "after sign-in" do
          it "should render the desired protected page" do
            expect(page).to have_title('Edit profile')
          end
        end
      end

      describe "in the User controller" do
        before { visit users_path }
        it { should have_title('Sign in') }
      end

    end


  end
end