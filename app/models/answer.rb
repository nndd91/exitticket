class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :form
  belongs_to :user
end
