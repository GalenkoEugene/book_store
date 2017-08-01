# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :order_status
  belongs_to :coupon, optional: true
  has_many :order_items
  before_validation :set_order_status, on: :create
  before_save :update_subtotal, :update_total

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  def total
    subtotal - discount
  end

  def discount
    self.coupon.try(:value) || 0.00
  end

  private

  def set_order_status
    self.order_status_id = OrderStatus.find_or_create_by(name: 'in_progress').id
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end

  def update_total
    self[:total] = total
  end
end
