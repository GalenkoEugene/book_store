# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Book page', type: :feature do
  context 'shared' do
    before { visit books_path }
    include_examples 'header and footer'
  end

  describe 'body' do
    before { visit books_path }
    subject { page.find('body') }
    it { expect(subject).to have_content 'Catalog' }
    it { expect(subject).to have_content 'Title A - Z' }
    it { expect(subject).to have_content 'Title Z - A' }
    it { expect(subject).to have_content 'Price: Low to hight' }
    it { expect(subject).to have_content 'Price: Hight to low' }
    it { expect(subject).to have_content 'Newest first' }
    it { expect(subject).to have_content 'Newest first' }
  end

  describe 'View more button' do
    before { FactoryGirl.create(:book) }
    it 'hide view more button', js: true do
      visit books_path
      expect(page).not_to have_content 'View More'
    end

    it 'show view more button', js: true do
      FactoryGirl.create_list(:book, 13)
      visit books_path
      expect(page).to have_content 'View More'
    end
  end
end
