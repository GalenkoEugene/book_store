# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Book page', type: :feature do
  before :each do
    @book = FactoryGirl.create(:book_with_review)
  end

  context 'shared' do
    before { visit book_path(@book) }
    include_examples 'header and footer'
  end

  describe 'body' do
    before { visit book_path(@book) }
    subject { page.find('body') }
    it { expect(subject).to have_content 'Back to results' }
    it { expect(subject).to have_content 'Year of publication' }
    it { expect(subject).to have_content 'Dimensions' }
    it { expect(subject).to have_content @book.title }
    it { expect(subject).to have_content @book.materials }
    it { expect(subject).to have_content @book.published_at }
  end

  # context 'short description' do
  #   it "'Read More' button absent", js: true do
  #     @book.description= 'text ' * 3
  #     @book.save!
  #     visit book_path(@book)
  #     expect(subject).not_to have_content 'Read More'
  #   end
  # end

  # context 'long description' do
  #   it "'Read More' button present", js: true do
  #     @book.description= 'text ' * 300
  #     @book.save!
  #     visit book_path(@book)
  #     expect(subject).to have_content 'Read More'
  #   end
  # end
end
