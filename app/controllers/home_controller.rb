# frozen_string_literal: true

# bestsellers and new_books are here
class HomeController < ApplicationController
  def index
    @latest_books = Book.last 3
    @best_sellers = Book.first 4
  end
end
