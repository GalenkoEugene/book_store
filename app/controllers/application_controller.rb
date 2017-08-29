# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include CurrentOrder
  include Current # user
  protect_from_forgery with: :exception
  before_action :categories
  around_action :set_current_user

  def categories
    @categories = Category.with_counted_books || Category.none
  end
end
