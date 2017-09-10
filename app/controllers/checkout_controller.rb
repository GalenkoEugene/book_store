# frozen_string_literal: true

class CheckoutController < ApplicationController
  include Wicked::Wizard
  before_action :fast_authentification

  steps :login, :address, :delivery, :payment, :confirm, :complete

  def show
    return redirect_to catalog_path if current_order.order_items.empty? && step != :complete
    case step
    when :login
      jump_to(next_step) if user_signed_in?
      cookies[:from_checkout] = { value: true, expires: 1.day.from_now } unless user_signed_in?
    when :address then @addresses = AddressesForm.new(show_addresses_params)
    when :delivery
      jump_to(previous_step) unless current_order.addresses.presence
      @deliveries = Delivery.all
    when :payment
      jump_to(previous_step) unless current_order.delivery
      @credit_card = current_order.credit_card || CreditCard.new
    when :confirm
      jump_to(previous_step) unless current_order.credit_card
      @addresses = AddressesForm.new(show_addresses_params)
    when :complete
      jump_to(previous_step) unless flash[:complete_order]
      @order = current_user.orders.processing_order.decorate
    end
    render_wizard
  end

  def update
    case step
    when :address
      @addresses = AddressesForm.new(addresses_params)
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

  def fast_authentification
    return unless user_signed_in? and step != :login
    jump_to(:login) unless user_signed_in?
  end

  def errors_for(subject)
    render json: subject.errors, callback: 'parse_errors', status: :unprocessable_entity
  end

  def show_addresses_params
    return { user_id: current_user.id } if current_order.addresses.empty?
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
