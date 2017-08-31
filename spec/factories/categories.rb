# frozen_string_literal: true

FactoryGirl.define do
  factory :category do
    sequence(:type_of) { |i| FFaker::Lorem.phrase + i.to_s }
  end
end
