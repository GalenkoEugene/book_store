# frozen_string_literal: true

class CheckoutController < ApplicationController
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    @addresses = AddressesForm.new(show_addresses_params)
    render_wizard
  end

  private

  def show_addresses_params
    return { user_id: current_user.id }  if current_order.addresses.empty?
    { order_id: current_order.id }
  end
end
