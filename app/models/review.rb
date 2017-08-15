# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, :book, :context, :score, presence: true
  validates :score,
    numericality: {
                    only_integer: true,
                    greater_than_or_equal_to: 1,
                    less_than_or_equal_to: 5
                  }
  scope :approved, -> { where(status: true) }
end