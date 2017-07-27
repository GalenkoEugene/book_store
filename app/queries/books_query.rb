# frozen_string_literal: true

# filter for books
class BooksQuery
  attr_reader :relation

  def initialize(relation = Book.all)
    @relation = relation
  end

  def run(filter_params)
    case filter_params
    when 'newest' then newest
    when 'popular' then popular
    when 'price_up' then price_up
    when 'price_down' then price_down
    else relation
    end
  end

  private

  def newest
    relation.order(updated_at: :desc)
  end

  def popular
    relation.order(price: :asc) # temporary solution
  end

  def price_up
    relation.order(price: :asc)
  end

  def price_down
    relation.order(price: :desc)
  end
end
