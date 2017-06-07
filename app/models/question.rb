class Question < ApplicationRecord
  belongs_to :form_template
  has_many :answers
end
