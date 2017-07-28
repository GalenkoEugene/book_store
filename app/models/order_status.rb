# frozen_string_literal: true

class OrderStatus < ApplicationRecord
  has_many :orders

  validates :name, presence: true, uniqueness: true
  validates_length_of :name, maximum: 30
end
