# frozen_string_literal: true

FactoryGirl.define do
  factory :author do
    name FFaker::Book.author
  end
end
