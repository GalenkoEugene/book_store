# frozen_string_literal: true

class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  validates :name, :file, :price, :amount, :description, :published_at, :dimension, :materials, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :name, uniqueness: true
  validates :file, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png|jpeg)\Z}i,
    message: 'must be a URL for GIF, JPG, JPEG or PNG image.'
  }
end
