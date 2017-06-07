class Form < ApplicationRecord
  belongs_to :form_template
  belongs_to :user
  has_many :questions, through: :form_template
end
