# frozen_string_literal: true

module CurrentSession
  thread_mattr_accessor :user
  attr_reader :back

  extend ActiveSupport::Concern
  included do
    helper_method :set_current_user
    helper_method :current_order
    helper_method :set_back_path
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

  def set_back_path
    session[:previous_request_url] = session[:current_request_url]
    session[:current_request_url] = request.path if request.path.match /\/(catalog|home|cart|checkout|orders)/
    @back = session[:previous_request_url]
  end
end
