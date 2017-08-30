FactoryGirl.define do
  factory :order_status do
    sequence(:name)

    trait :delivered do
      name 'delivered'
    end
    trait :in_progtess do
      name 'in_progtess'
    end
  end
end
