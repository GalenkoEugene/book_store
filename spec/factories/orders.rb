FactoryGirl.define do
  factory :order do
    subtotal 10
    total 20
    association :order_status
    association :user
  end
end
