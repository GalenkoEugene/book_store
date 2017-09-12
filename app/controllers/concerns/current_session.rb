# frozen_string_literal: true

module CurrentSession
  thread_mattr_accessor :user
  attr_reader :back

  extend ActiveSupport::Concern
  included do
    around_action :set_current_user
    before_action :set_back_path
    helper_method :current_order

    def after_sign_in_path_for(resource)
      if cookies[:from_checkout]
        cookies.delete :from_checkout
        checkout_path(:addresses)
      else
        super
      end
    end
  end

  def current_order
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

  private

  def order_id
    current_user ? current_user.order_in_progress&.id : session[:order_id]
  end
end
