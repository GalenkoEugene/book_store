# frozen_string_literal: true

module CurrentOrder
  extend ActiveSupport::Concern

  included { helper_method :current_order }

  def current_order
    return Order.new if session[:order_id].nil?
    Order.find(session[:order_id])
  end
end
