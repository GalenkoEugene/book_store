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
end
