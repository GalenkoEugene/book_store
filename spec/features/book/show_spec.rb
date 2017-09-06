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

  context 'short description' do
    it "'Read More' button absent", js: true do
      @book.description= 'text ' * 3
      @book.save!
      visit book_path(@book)
      expect(page).not_to have_content 'Read More'
    end
  end

  # context 'long description' do
  #   it "'Read More' button present", js: true do
  #     @book.description= 'text ' * 400
  #     @book.save!
  #     visit book_path(@book)
  #     expect(page).to have_content 'Read More'
  #   end
  # end

  describe 'Add to Cart' do
    let(:shop_icon) { page.find('a.hidden-xs>span.shop-icon') }
    let(:plus) { find(:xpath, ".//a[child::i[contains(@class,\"fa-plus\")]]") }
    let(:minus) { find(:xpath, ".//a[child::i[contains(@class,\"fa-minus\")]]") }
    before { visit book_path(@book) }

    it 'has no items in cart' do
      expect(page).not_to have_css 'span.shop-quantity'
      expect(shop_icon).to have_content ''
    end

    context 'amount of books' do
      it 'increase quantity', js: true do
        plus.trigger('click')
        expect(page.find('#order_item_quantity').value).to eq '1'
      end

      it 'can`t be less then 1', js: true do
        minus.trigger('click')
        expect(page.find('#order_item_quantity').value).to eq '1'
      end
    end

    it 'add four items into cart', js: true do
      fill_in 'order_item[quantity]', with: '4'
      click_on I18n.t('button.add_to_cart')
      expect(shop_icon).to have_content '4'
    end

    it 'add one item into cart', js: true do
      click_on I18n.t('button.add_to_cart')
      expect(shop_icon).to have_content '1'
    end
  end
end
