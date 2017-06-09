FactoryGirl.define do
  factory :form do
    association :form_template
    association :user
    form_date "2017-06-07"
    title "MyString"
    description "MyString"

    trait :invalid do
      title nil
    end
  end
end
