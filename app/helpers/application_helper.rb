# frozen_string_literal: true

module ApplicationHelper
  def authors_to_list(book)
    book.authors.pluck(:name).join(', ')
  end

  def shop_icon_quantity(order)
    qty = order.order_items.collect(&:quantity).sum
    "<span class='shop-quantity'>#{qty}</span>".html_safe unless qty.zero?
  end

  def active_class(link_path)
    return '' if request.GET.empty?
    (link_path.include? request.GET.first.join('=')) ? 'active' : ''
    # current_page?(link_path) ? 'active' : ''
  end

  def country_name(object)
    country = ISO3166::Country[object.country]
    country.translations[I18n.locale.to_s] || country.name
  end
end
