# frozen_string_literal: true

module Showable
  extend ActiveSupport::Concern

  included do

    private

    def show_login
      return jump_to(next_step) if user_signed_in?
      cookies[:from_checkout] = { value: true, expires: 1.day.from_now }
    end

    def show_addresses
      @addresses = AddressesForm.new(show_addresses_params)
    end

    def show_delivery
      return jump_to(previous_step) unless current_order.addresses.presence
      @deliveries = Delivery.all
    end

    def show_payment
      return jump_to(previous_step) unless current_order.delivery
      @credit_card = current_order.credit_card || CreditCard.new
    end

    def show_confirm
      return jump_to(previous_step) unless current_order.credit_card
      show_addresses
    end

    def show_complete
      return jump_to(previous_step) unless flash[:complete_order]
      @order = current_user.orders.processing_order.decorate
    end

    def fast_authentification!
      return unless user_signed_in? and step != :login
      jump_to(:login) unless user_signed_in?
    end

    def show_addresses_params # take data from settings if persist
      return { user_id: current_user.id } if current_order.addresses.empty?
      { order_id: current_order.id }
    end
  end
end
