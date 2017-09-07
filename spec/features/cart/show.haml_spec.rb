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

    context 'click minus', :skip do
      it 'increase amount of books in shopping cart'
      it 'increase Quantity field'
      it 'recalculate SubTotal price'
      it 'recalculate Order Total price'
    end

    context 'click Item details' do
      it 'go to book show page'
      context 'click Back to results' do
        it 'return back to shopping cart'
      end
    end

    describe 'Coupon' do
      context 'upply valid coupon' do
        it 'show success message'
        it 'set discount'
        it 'do not recalculate SubTotal price'
        it 'recalculate Order Total price'
      end

      context 'try to apply invalid coupon' do
        it 'show error message'
        it 'do nothing with Order Total and SubTotal prices'
      end
    end

    describe 'Checkout' do
      context 'loged in user' do
        it 'transferred to the Checkout page, the Addresses tab'
      end

      context 'guest user' do
        it 'transferred to the Checkout Login page'
      end

      context 'empty cart' do
        it 'redirect to catalog page'
      end
    end
  end
end
