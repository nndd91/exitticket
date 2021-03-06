class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations for additional fields
  validates :last_name, presence: true, length: { maximum: 30, minimum: 2 }
  validates :first_name, presence: true, length: { maximum: 30, minimum: 2 }
  validates :username, presence: true, length: { maximum: 30, minimum: 2 }, uniqueness: true

  # Associations
  has_many :form_templates, dependent: :destroy
  has_many :forms, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :logs, dependent: :destroy
end

