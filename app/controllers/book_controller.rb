# frozen_string_literal: true

# book
class BookController < ApplicationController
  before_action :book, only: [:show]
  before_action :categories
  respond_to :html, :js, only: [:index]

  def index
    @category_id = params[:category]
    @books = Book.includes(:authors).by_category(params[:category]).page(params[:page])
  end

  def show
    redirect_to root_url, alert: 'No such book.' unless @book
  end

  private

  def book
    @book = Book.find_by_id(params[:id])
  end

  def book_params
    params.require(:book).permit(:name)
  end
end
