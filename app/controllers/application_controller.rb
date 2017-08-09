# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include CurrentOrder
  protect_from_forgery with: :exception
  before_action :categories

  def categories
    @categories = Category.includes(:books).all || Category.none
  end
end
