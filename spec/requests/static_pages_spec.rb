require 'spec_helper'

describe "Static pages" do

  let(:link_text) { "Yizkor" }

  describe "Home page" do

    it "should have title 'Main page'" do
      visit root_path
      expect(page).to have_title('Main Page')
    end

    it "should have the content 'Yizkor'" do
      visit root_path
      expect(page).to have_content('Yizkor')
    end

    it "should have a link with content 'Yizkor'" do
      visit root_path
      expect(page).to have_content("#{link_text}")
    end
  
  end

  describe "Contact page" do

    it "should have the content 'Contact" do
      visit contact_path
      expect(page).to have_content('Contact')
    end

    it "should have title 'Contact'" do
      visit contact_path
      expect(page).to have_title('Contact')
    end

  end

end
