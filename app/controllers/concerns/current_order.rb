# frozen_string_literal: true

module CurrentOrder
  extend ActiveSupport::Concern

  included { helper_method :current_order }

  def current_order
    order_id = current_user ? current_user.orders.in_progress : session[:order_id]
    Order.find_or_initialize_by(id: order_id).decorate
  end
end
