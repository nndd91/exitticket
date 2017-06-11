class Form < ApplicationRecord
  belongs_to :form_template
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :questions, through: :form_template
  has_many :logs, dependent: :destroy

  #attr_accessor :q1, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :q9, :q10, :q11, :q12, :q13, :q14, :q15

  for i in (1..15) do
    #attr_accessor ('q'+(i+1).to_s).to_sym
  end

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 1000 }

  #validates_presence_of :q1, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :q9, :q10
end
