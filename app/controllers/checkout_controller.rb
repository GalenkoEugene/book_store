class CheckoutController < ApplicationController
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    @shipping = current_user.addresses.find_or_initialize_by(type: 'Billing')
    @billing = current_user.addresses.find_or_initialize_by(type: 'Shipping')
    render_wizard
  end
end
