class Delivery < ApplicationRecord
  has_many :orders
  validates :method, :duration, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates_length_of :method, in: 3..100
end
