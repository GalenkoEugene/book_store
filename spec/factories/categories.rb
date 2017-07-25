# frozen_string_literal: true

FactoryGirl.define do
  factory :category do
    type_of { FFaker::Lorem.phrase }
  end
end
