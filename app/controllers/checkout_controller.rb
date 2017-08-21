# frozen_string_literal: true

class CheckoutController < ApplicationController
  include Wicked::Wizard
  before_action :authenticate_user!

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    return redirect_to catalog_path if current_order.order_items.empty?
    @addresses = AddressesForm.new(show_addresses_params)
    @deliveries = Delivery.all
    @credit_card = current_order.credit_card || CreditCard.new
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
      @credit_card = current_order.credit_card || CreditCard.new
      @credit_card.update_attributes(credit_card_params)
      if @credit_card.save
        current_order.update_attributes(credit_card_id: @credit_card.id)
        redirect_to next_wizard_path
      else
        render json: @credit_card.errors, callback: 'parse_errors', status: :unprocessable_entity
      end
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

  def credit_card_params
    params.require(:credit_card).permit(:number, :name, :mm_yy, :cvv)
  end
end
