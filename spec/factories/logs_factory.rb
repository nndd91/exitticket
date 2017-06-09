FactoryGirl.define do
  factory :log do
    association :form
    association :user
  end
end
