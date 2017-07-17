# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @best_sellers = Book.first 4
  end
end
