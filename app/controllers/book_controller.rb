# frozen_string_literal: true

# book
class BookController < ApplicationController
  # before_action :book, only: [:show]

  def index
    @books = Book.all
  end

  def show
    @book = Book.includes(:authors).first
  end

  private

  def book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name)
  end
end
