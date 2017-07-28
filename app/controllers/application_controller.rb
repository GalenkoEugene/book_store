# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :categories
  helper_method :current_order

  def current_order
    return Order.new if session[:order_id].nil?
    Order.find(session[:order_id])
  end

  def categories
    @categories = Category.includes(:books).all || Category.none
  end
end
