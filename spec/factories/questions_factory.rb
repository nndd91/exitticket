FactoryGirl.define do
  factory :question do
    form_template nil
    qns_type "Text Field"
    label "MyString"
    options "MyString"
    sequence(:qns_no) { |n| n }
    required true
  end
end
