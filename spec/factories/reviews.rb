FactoryGirl.define do
  factory :review do
    score 5
    context 'review context'
    association :user
    association :book
  end
end
