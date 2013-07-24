require 'spec_helper'

describe "UserPages" do

	describe "Sign Up" do
		before { visit signup_path }
		subject { page }

		it {should have_content('everything') }
		it {should have_title(full_title('Sign Up')) }

	end


  describe "profile page" do
    let(:u) { User.find_by(id: 1) }
    before { visit user_path(u) }
    binding.pry

    it { should have_content(u.email) }
    it { should have_title(u.email) }
  end

end
