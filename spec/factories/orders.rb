FactoryGirl.define do
  factory :order do
    subtotal 10
    total 20
    association :order_status
  end
end
