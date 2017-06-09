class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :form
  belongs_to :user

  validates :question, presence: true
  validates :form, presence: true
  validates :user, presence: true
  validates :content, presence: true
end
