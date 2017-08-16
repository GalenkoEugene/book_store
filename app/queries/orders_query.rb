# frozen_string_literal: true

# filter for books
class OrdersQuery
  attr_reader :relation

  def initialize(relation = Order.none)
    @relation = relation
  end

  def run(filter_params = '')
    status_id = OrderStatus.find_by_name(filter_params)
    return relation.where(order_status_id: status_id) if status_id
    relation
  end
end

