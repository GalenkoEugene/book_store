FactoryGirl.define do
  factory :order_item do
    association :book
    association :order
    unit_price 1.0
    quantity 1
    total_price 1.0

    factory :order_item_with_delivered_book do
      after(:create) do |order_item, _evaluator|
        order_item.order_id= FactoryGirl.create(:order, :delivered).id
        order_item.save
      end
    end
  end
end
