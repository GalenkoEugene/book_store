# frozen_string_literal: true

module CurrentSession
  thread_mattr_accessor :user

  extend ActiveSupport::Concern
  included do
    helper_method :set_current_user
    helper_method :current_order
  end

  def current_order
    order_id = current_user ? current_user.order_in_progress&.id : session[:order_id]
    @current_order ||= Order.find_or_initialize_by(id: order_id).decorate
  end

  def set_current_user
    CurrentSession.user = current_user
    yield
  ensure
    CurrentSession.user = nil
  end
end
