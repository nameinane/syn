require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      it { should have_selector('div.pagination') }
      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
  end

  describe "viewing user profile" do
    describe "works fine when signed in" do
      let(:u) { FactoryGirl.create(:user) }
      before do
        sign_in u
        visit user_path(u)
      end

      it { should have_content(u.email) }
      it { should have_title(u.name) }
      # binding.pry
    end

    describe "does not work when NOT signed in" do
      let(:u) { FactoryGirl.create(:user) }
      before { visit user_path(u) }

      it { should_not have_content(u.email) }
      it { should_not have_title(u.name) }
      # binding.pry
    end

  end




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

	 		describe "after submission" do
	      before { click_button submit }

	      it { should have_title('Sign Up') }
	      it { should have_content('error') }
	    end

    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Name Inanesky"
        fill_in "Email",        with: "nameinane@gmail.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

			describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'nameinane@gmail.com') }

        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: "You're in.") }
      end

      describe "after sign in" do
        let(:user) { FactoryGirl.create(:user) }
        before { sign_in user }

        it { should have_link('Settings') }
        it { should have_link('Profile') }
        it { should have_link('Sign out') }
        it { should_not have_link('Sign in') }
      end
    end
  end




  describe "edit page" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end


    describe "page" do
      it { should have_content("Edit profile") }
      it { should have_title("Edit profile") }
      it { should have_link("change", href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_error_message('error') }
    end

    describe "with valid information" do
      let(:new_name) { "Serious Name" }
      let(:new_email) { "serious@name.com" }

      before do 
        fill_in "Name",                 with: new_name
        fill_in "Email",                with: new_email
        fill_in "Password",             with: user.password
        fill_in "Confirm Password",     with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }

      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end