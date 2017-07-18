# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books

  validates :title, :price, :description,
            :published_at, :height, :weight, :depth,
            :materials, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :height, :weight, :depth, numericality: { only_float: true }
  validates :published_at, numericality: { less_than_or_equal_to: Time.now.year }
  validates :title, uniqueness: true
  validates_length_of :title, maximum: 120
  validates_length_of :materials, maximum: 80
  validates_length_of :description, in: 5..2000
end
