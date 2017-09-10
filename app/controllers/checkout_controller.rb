# frozen_string_literal: true

class CheckoutController < ApplicationController
  before_action :fast_authentification!
  include Wicked::Wizard
  include Showable

  steps :login, :addresses, :delivery, :payment, :confirm, :complete

  def show
    return redirect_to catalog_path if no_items_in_cart?
    send("show_#{step}")
    render_wizard
  end

  def update
    case step
    when :addresses
      @addresses = AddressesForm.new(params)
      return errors_for(@addresses) unless @addresses.save
    when :delivery
      current_order.update_attributes(order_params)
      flash[:notice] = t('delivery.pickup') if current_order.delivery_id.nil?
    when :payment
      @credit_card = CreditCard.new(credit_card_params)
      return errors_for(@credit_card) unless @credit_card.save
    when :confirm
      flash[:complete_order] = true
      session[:order_id] = nil if current_order.finalize
    end
    redirect_to next_wizard_path
  end

  private

  def errors_for(subject)
    render json: subject.errors, callback: 'parse_errors', status: :unprocessable_entity
  end

  def order_params
    params.require(:order).permit(:delivery_id)
  end

  def credit_card_params
    params.require(:credit_card).permit(:number, :name, :mm_yy, :cvv)
  end

  def no_items_in_cart?
    current_order.order_items.empty? && step != :complete
  end
end
