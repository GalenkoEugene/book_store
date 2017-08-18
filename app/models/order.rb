# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :order_status
  belongs_to :coupon, optional: true
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
  before_validation :set_order_status, on: :create
  before_save :update_subtotal, :update_total, :connect_to_user

  scope :where_status, -> (status_name) { joins(:order_status).where(order_statuses: { name: status_name }) }

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  def total
    subtotal - discount
  end

  def discount
    coupon.try(:value) || 0.00
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

  def connect_to_user
    self[:user_id] = Current.user.id unless Current.user.nil?
  end
end
