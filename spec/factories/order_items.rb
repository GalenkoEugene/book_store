FactoryGirl.define do
  factory :order_item do
    association :book
    association :order
    unit_price 1.0
    quantity 1
    total_price 1.0
  end
end
