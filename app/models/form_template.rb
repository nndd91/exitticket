class FormTemplate < ApplicationRecord
  belongs_to :user
  has_many :forms, dependent: :destroy
  has_many :questions, dependent: :destroy

  validates :user, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 1000 }
end
