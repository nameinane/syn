require 'spec_helper'

describe "UserPages" do

	describe "Sign Up" do
		before { visit signup_path }
		subject { page }

		it {should have_content('everything') }
		it {should have_title(full_title('Sign Up')) }

	end

end
