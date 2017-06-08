class FormTemplate < ApplicationRecord
  belongs_to :user
  has_many :forms, dependent: :destroy
  has_many :questions, dependent: :destroy

end
