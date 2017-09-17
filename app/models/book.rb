# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  has_many :order_items, dependent: :nullify
  has_many :reviews, dependent: :destroy
  belongs_to :category
  has_many :images, dependent: :destroy
  has_many :orders, through: :order_items
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

  scope :best_sellers, -> { joins(:orders).merge(Order.where_status('delivered')).includes(:authors).group(:id).sort_by {|_,v| v}.reverse }
  # scope :the_best_sellers, -> { where(id: grouped_best_sellers_ids) }

  # def self.grouped_best_sellers_ids
  #   Book.group(:category_id).joins(:orders).merge(Order.where_status('delivered')).group(:id).count.sort_by {|_,v| v}.reverse.transpose.first.flat_map(&:second)
  # end

  def self.by_category(cat_id)
    cat_id ? where('category_id = ?', cat_id) : unscoped
  end
end
