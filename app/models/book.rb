# frozen_string_literal: true

class Book < ApplicationRecord
  before_destroy :break_if_many_authors

  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  has_many :order_items
  has_many :reviews, dependent: :destroy
  belongs_to :category
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :title, :price, :description,
            :published_at, :height, :weight, :depth,
            :materials, :category_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :height, :weight, :depth, numericality: { only_float: true }
  validates :published_at, numericality: {
                             greater_than_or_equal_to: 1900,
                             less_than_or_equal_to: Time.now.year
                           }
  validates :title, uniqueness: true
  validates_length_of :title, maximum: 120
  validates_length_of :materials, maximum: 80
  validates_length_of :description, in: 5..2000

  def self.by_category(cat_id)
    cat_id ? where('category_id = ?', cat_id) : unscoped
  end

  def break_if_many_authors
    throw :abort if self.authors.size > 1
  end
end
