# frozen_string_literal: true

require 'ffaker'
FactoryGirl.define do
  factory :book do
    title   FFaker::Book.title
    price   35.00
    description FFaker::Book.description
    published_at 2015
    height  1.1
    weight  2.0
    depth   0.8
    materials 'paper, silk'
    category_id { FactoryGirl.create(:category).id }
  end
end
