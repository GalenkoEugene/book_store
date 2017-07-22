# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Home page', type: :feature do
  before :each { visit root_path }
  include_examples 'header and footer'

  describe 'body' do
    subject { page.find('body') }
    it { expect(subject).to have_selector :link_or_button, 'Get Started' }
    it { expect(subject).to have_content 'Welcome to our amazing Bookstore!' }
    it { expect(subject).to have_content 'Best Sellers' }

    context '"Get Started" button redirect to \'/catalog\'' do
      before { click_link 'Get Started' }
      it { expect(page).to have_http_status(:success) }
      it { expect(page).to have_content 'Catalog' }
      it { expect(page).to have_content 'View More' }
    end
  end
end
