class FormTemplate < ApplicationRecord
  belongs_to :user
  has_many :questions
  has_many :forms
end
