# frozen_string_literal: true

class BookController < ApplicationController
  # before_action :get_book, only: [:show]

  def index
    @books = Book.all
  end

  def show
    @book = Book.first
  end

  private

  def get_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name)
  end
end
