FactoryGirl.define do
  factory :user do
    first_name "dasdas"
    last_name "dasdas"
    sequence(:username) {|n| "dasdas#{n}" }
    sequence(:email ) { |n| "email#{n}@example.com" }
    password "password"

    trait :admin do
      is_admin true
    end
  end
end
