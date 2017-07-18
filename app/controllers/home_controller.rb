# frozen_string_literal: true

# bestsellers and new_books are here
class HomeController < ApplicationController
  def index
    @best_sellers = Book.first 4
  end
end
