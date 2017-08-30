FactoryGirl.define do
  factory :order do
    subtotal 1
    total 1
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

    trait :in_queue do
      after(:create) do |order|
        order.order_status = OrderStatus.find_by(name: :in_queue) || FactoryGirl.create(:order_status, :in_queue)
        order.save!
      end
    end
  end
end
