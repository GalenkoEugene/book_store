# frozen_string_literal: true

FactoryGirl.define do
  factory :category do
    type_of 'Mobile development' # 'Photo' 'Web design' 'Web development'
  end
end
