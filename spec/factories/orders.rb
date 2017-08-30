FactoryGirl.define do
  factory :order do
    subtotal 10
    total 20
    order_status
    user

    trait :in_progress do
      after(:create) do |order|
        order.order_status = OrderStatus.find_by(name: :in_progress) || FactoryGirl.create(:order_status, :in_progress)
        order.save!
      end
    end

    trait :delivered do
      after(:create) do |order|
        order.order_status = OrderStatus.find_by(name: :delivered) || FactoryGirl.create(:order_status, :delivered)
        order.save!
      end
    end
  end
end
