FactoryGirl.define do
  factory :order_status do
    sequence(:name)

    trait :delivered do
      name 'delivered'
    end

    trait :in_progtess do
      name 'in_progtess'
    end

    trait :in_queue do
      name 'in_queue'
    end
  end
end
