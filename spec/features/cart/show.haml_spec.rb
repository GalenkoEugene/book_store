# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Cart page', type: :feature do
  before :each { visit cart_path }
  include_examples 'header and footer'

  describe 'body' do
    subject { page.find('body') }
    it { expect(subject).to have_content 'Cart' }
    it { expect(subject).to have_selector :link_or_button, 'Checkout' }
    it { expect(subject).to have_selector :link_or_button, 'Update cart' }
    it { expect(subject).to have_content 'Order Summary' }
    it { expect(subject).to have_content 'SubTotal:' }
    it { expect(subject).to have_content 'Coupon:' }
    it { expect(subject).to have_content 'Order Total:' }
    it { expect(subject).to have_content 'Coupon' }
    it { expect(subject).to have_content 'Quantity' }
  end

  describe 'update cart' do
    let(:qqty_input_field) { page.find('div.hidden-xs input.quantity-input') }
    let(:plus) { find(:linkhref, "/order_items/#{@order_item.order_id}?order_item%5Bquantity%5D=#{qqty_input_field.value.to_i+1}") }
    let(:minus) { find(:linkhref, "/order_items/#{@order_item.order_id}?order_item%5Bquantity%5D=#{qqty_input_field.value.to_i-1}") }
    let(:cross) { find }

    before do
      @order_item = FactoryGirl.create(:order_item)
      inject_session order_id: @order_item.order.id
      visit cart_path
    end

    context 'click plus', :skip do
      it 'increase amount of books in shopping cart', js: true do
        expect(qqty_input_field.value).to eq '1'
        within('main div.hidden-xs') do
          minus.click
        end
        expect(qqty_input_field.value).to eq '2'
      end
      it 'increase Quantity field'
      it 'recalculate SubTotal price'
      it 'recalculate Order Total price'
    end

    context 'click minus' do
      it 'increase amount of books in shopping cart'
      it 'increase Quantity field'
      it 'recalculate SubTotal price'
      it 'recalculate Order Total price'
    end

    context 'click Item details' do
      it 'go to book show page' do
      end
      context 'click Back to results' do
        it 'return back to shopping cart'
      end
    end

    describe 'Coupon' do
      context 'upply valid coupon' do
        let(:coupon) { FactoryGirl.create(:coupon, name: 'valid_coupon_ok', value: 99.9) }

        before do
          fill_in I18n.t('cart.coupon'), with: coupon.name
          click_on I18n.t('cart.update')
        end

        it 'show success message' do
          expect(page).to have_content I18n.t('flash.coupon_applied')
        end

        it 'set discount' do
          expect(page).to have_content coupon.value
        end
      end

      context 'try to apply invalid coupon' do
        let(:invalid_coupon) { 'invalid_coupon' }

        before do
          fill_in I18n.t('cart.coupon'), with: invalid_coupon
          click_on I18n.t('cart.update')
        end

        it 'show error message' do
          expect(page).to have_content I18n.t('flash.fake_coupon')
        end
      end
    end

    describe 'Checkout' do
      context 'guest user', :skip do
        it 'transferred to the Checkout Login page', js: true do
          visit home_path
          find('input[value="Buy Now"]').click
          find('a.shop-link.pull-right.hidden-xs').click
          click_on 'Checkout'
          expect(page).to have_content 'Returning Customer'
          expect(page).to have_content 'New Customer'
          expect(page).to have_content 'Quick Register'
        end
      end



      context 'loged in user' do
        before { sign_in_as_user }

        context 'empty cart' do
          it 'redirect to catalog page' do
            find('a.shop-link.pull-right.hidden-xs').click
            click_on 'Checkout'
            expect(page).to have_content I18n.t('page.book.index.catalog')
          end
        end

        it 'transferred to the Checkout page, the Addresses tab', js: true do
          find('input[value="Buy Now"]').click
          find('a.shop-link.pull-right.hidden-xs').click
          click_on 'Checkout'
          expect(page).to have_content I18n.t('settings.billing')
          expect(page).to have_content I18n.t('settings.shipping')
        end
      end
    end
  end
end
