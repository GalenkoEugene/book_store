# frozen_string_literal: true

class CreditCard < ApplicationRecord
  validates :number, :name, :mm_yy, :cvv, presence: true
  has_many :orders
end
