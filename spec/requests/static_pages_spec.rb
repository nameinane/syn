require 'spec_helper'

describe "Static pages" do

  let(:link_text) { "Ruby on Rails Tutorialzz" }

  describe "Home page" do

    it "should have the content 'Holmesz'" do
      visit '/static_pages/home'
      expect(page).to have_title('Holmesz')
    end

    it "should have the content 'Find me'" do
      visit '/static_pages/home'
      expect(page).to have_content('me')
    end

    it "should have a link with content 'Ruby on Rails Tutorial'" do
      visit '/static_pages/home'
      expect(page).to have_content("#{link_text}")
    end


  end
end
