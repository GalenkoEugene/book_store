# frozen_string_literal: true

require 'ffaker'

FactoryGirl.define do
  factory :author do
    name FFaker::Book.author
  end
end
