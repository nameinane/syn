require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Holmesz'" do
      visit '/static_pages/home'
      expect(page).to have_title('Holmesz')
    end

    it "should have the content 'Find me'" do
      visit '/static_pages/home'
      expect(page).to have_content('me')
    end

  end
end
