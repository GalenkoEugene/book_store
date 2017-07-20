class Category < ApplicationRecord
  has_many :books
  validates :type_of, presence: true, uniqueness: true
end
