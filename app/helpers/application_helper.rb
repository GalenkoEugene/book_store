# frozen_string_literal: true

module ApplicationHelper
  def authors_to_list(book)
    book.authors.map(&:name).join(', ')
  end

  def shop_icon_quantity(order)
    qty = order.order_items.collect(&:quantity).sum
    "<span class='shop-quantity'>#{qty}</span>".html_safe unless qty.zero?
  end
end
