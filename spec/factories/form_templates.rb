FactoryGirl.define do
  factory :form_template do
    title "MyString"
    description "MyString"
    association :user

    trait :invalid do
      title nil
    end
  end
end
