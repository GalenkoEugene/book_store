# frozen_string_literal: true

class CheckoutController < ApplicationController
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    @addresses = AddressesForm.new(show_addresses_params)
    @deliveries = Delivery.all
    render_wizard
  end

  def update
    case step
    when :address
      @addresses = AddressesForm.new(addresses_params)
      return  redirect_to next_wizard_path if @addresses.save
      render json: @addresses.errors, callback: 'parse_errors', status: :unprocessable_entity
    when :delivery
      current_order.update_attributes(order_params)
      redirect_to next_wizard_path
    when :payment

    end
  end

  private

  def show_addresses_params
    return { user_id: current_user.id }  if current_order.addresses.empty?
    { order_id: current_order.id }
  end

  def addresses_params
    %i[shipping billing].each { |type| params[type][:order_id] = current_order.id }
    params
  end

  def order_params
    params.require(:order).permit(:delivery_id)
  end
end
