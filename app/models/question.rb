class Question < ApplicationRecord
  belongs_to :form_template
  has_many :answers, dependent: :destroy

  enum qns_type: { "Text Field": 1, "1 to 5 Collection": 2, "Text Area":3 }
end
