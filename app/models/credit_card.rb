# frozen_string_literal: true

class CreditCard < ApplicationRecord
  validates :number, :name, :mm_yy, :cvv, presence: true
  has_many :orders

  after_save :connect_to_order

  def connect_to_order
    user = Current.user unless Current.user.nil?
    user.orders.where_status(:in_progress).first.update_attributes(credit_card_id: self.id)
  end
end
