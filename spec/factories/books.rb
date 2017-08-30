# frozen_string_literal: true

require 'ffaker'

FactoryGirl.define do
  factory :book do
    transient do
      cost 35.00
    end

    price 1.0
    sequence(:title)  { |i| FFaker::Book.title + i.to_s }
    description FFaker::Book.description
    published_at 2015
    height 1.1
    weight 2.0
    depth 0.8
    materials 'paper, silk'
    association :category

    after(:create) do |book, evaluator|
      book.price= evaluator.cost
    end
  end
end
