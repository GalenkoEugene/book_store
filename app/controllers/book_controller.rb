# frozen_string_literal: true

# book
class BookController < ApplicationController
  before_action :order_item
  respond_to :html, :js, only: [:index]

  def index
    filters
    books = Book.by_category(params[:category]).includes(:authors)
    @books = BooksQuery.new(books).run(params[:filter]).page(params[:page])
  end

  def show
    @book = Book.find_by_id(params[:id])
    @reviews = @book.reviews.approved.decorate
    redirect_to root_url, alert: 'No such book.' unless @book
  end

  private

  def order_item
    @order_item = current_order.order_items.new
  end

  def filters
    @category_id = params[:category]
    @filter = params[:filter]
  end

  def book_params
    params.require(:book).permit(:name)
  end
end
