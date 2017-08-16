# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :user

  scope :shipping, -> { where(type: 'Shipping') }
  scope :billing, -> { where(type: 'Billing') }

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true
  validates_length_of :first_name, :last_name, :address, :city, :country, maximum: 50
  validates :first_name, :last_name, :city, format: { with: /[A-Za-z]/ }
  validates_length_of :phone, maximum: 15
  validates_length_of :zip, maximum: 10
end
