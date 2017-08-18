# frozen_string_literal: true

module CurrentOrder
  extend ActiveSupport::Concern

  included { helper_method :current_order }

  def current_order
    in_progress = current_user.orders.where_status('in_progress') if current_user
    order_id_from_db = current_user ? in_progress.first.try(:id) : false
    order_id = order_id_from_db || session[:order_id]
    return Order.new unless order_id
    Order.find(order_id)
  end
end
