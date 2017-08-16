# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include CurrentOrder
  include Current
  protect_from_forgery with: :exception
  before_action :categories
  around_action :set_current_user

  def categories
    @categories = Category.includes(:books).all || Category.none
  end
end
