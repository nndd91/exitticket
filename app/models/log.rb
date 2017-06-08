class Log < ApplicationRecord
  belongs_to :form
  belongs_to :user
  validates :user, presence: true
  validates :form, presence: true, uniqueness: { scope: :user, message: "Each user can only do once!"}
end
