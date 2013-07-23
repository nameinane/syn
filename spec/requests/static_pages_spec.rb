require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: h1_text) }
    it { should have_title(full_title(page_title)) }
  end


  describe "Home page" do
    before { visit root_path }

    let(:link_text) { "Yizkor" }
    let(:h1_text) { "Welcome" }
    let(:page_title) { "" }

    it_should_behave_like "all static pages"
    it { should have_content('Yizkor') }
    it { should have_content("#{link_text}") }

    it "should have the right links on the layout" do
      click_link "Contact"
      expect(page).to have_title ('Contact Us')
    end
  
  end

  describe "Contact page" do
    before { visit contact_path }

    let(:h1_text) {"Contact"}
    let(:page_title) {"Contact"}

    it_should_behave_like "all static pages"
    it { should have_selector('h2', text: 'some other way') }
    it { should_not have_title('Home') }

  end

end
