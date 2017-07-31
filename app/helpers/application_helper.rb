# frozen_string_literal: true

module ApplicationHelper
  def authors_to_list(book)
    book.authors.map(&:name).join(', ')
  end

  def shop_icon_quantity(qty)
    "<span class='shop-quantity'>#{qty}</span>".html_safe unless qty.to_i.zero?
  end
end
