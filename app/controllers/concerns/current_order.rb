# frozen_string_literal: true

module CurrentOrder
  extend ActiveSupport::Concern

  included { helper_method :current_order }

  def current_order
    in_progress = OrderStatus.where(name: 'in_progress')
    order_id_from_db = current_user.nil? ? false : current_user.orders.where(order_status: in_progress).first.try(:id)
    order_id = order_id_from_db || session[:order_id]
    return Order.new unless order_id
    Order.find(order_id)
  end
end
