# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Home page', type: :feature do
  before :each { visit root_path }
  include_examples 'header and footer'
  let(:quantity) { page.find('a.hidden-xs>span.shop-icon') }

  describe 'body' do
    subject { page.find('body') }
    it { expect(subject).to have_selector :link_or_button, 'Get Started' }
    it { expect(subject).to have_content I18n.t('page.home.greeting') }
    it { expect(subject).to have_content I18n.t('page.home.text') }
    it { expect(subject).to have_content I18n.t('page.home.best_sellers') }
    it { expect(subject).to have_content I18n.t('button.get_started') }

    context '"Get Started" button redirect to \'/catalog\'' do
      before { click_link 'Get Started' }
      it { expect(page).to have_http_status(:success) }
      it { expect(page).to have_content I18n.t('page.book.index.catalog') }
      it { expect(page).to have_content I18n.t('button.view_more') }
    end

    context "'Buy now' button add one book to shoping cart" do
      subject { page.find('div.carousel-inner') }

      before do
        FactoryGirl.create(:book, title: 'Ruby on Rails best practice')
        visit root_path
      end

      it 'have last book in carousel' do
        expect(subject).to have_content 'Ruby on Rails best practice'
      end

      it 'have now books in cart' do
        expect(page).not_to have_css 'span.shop-quantity'
        expect(quantity).to have_content ''
      end

      it 'add book to shopping cart', js: true do
        find('input[value="Buy Now"]').click
        expect(page).to have_css 'span.shop-quantity'
        expect(quantity).to have_content '1'
      end
    end

    context 'Best Sellers/shopping-cart thumb-icon' do
      before do
        @item = FactoryGirl.create(:order_item_with_delivered_book)
        visit root_path
      end

      it 'has empty cart' do
        expect(page).not_to have_css 'span.shop-quantity'
      end

      it 'add book to shoping cart', js: true do
        find(:shoping_cart_icon, @item.book).click
        expect(page).to have_css 'span.shop-quantity'
        expect(quantity).to have_content '1'
      end
    end
  end
end
