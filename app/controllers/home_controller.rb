# frozen_string_literal: true

# bestsellers and new_books are here
class HomeController < ApplicationController
  def index
    @latest_books = Book.includes(:authors).last 3
    @best_sellers = Book.includes(:authors).first 4
  end
end
