# frozen_string_literal: true

module CurrentOrder
  extend ActiveSupport::Concern

  included { helper_method :current_order }

  def current_order
    in_progress = current_user.orders.where_status('in_progress') if current_user
    order_id_from_db = current_user ? in_progress.first.try(:id) : false
    order_id = order_id_from_db || session[:order_id]
    Order.find_or_initialize_by(id: order_id).decorate
  end
end
