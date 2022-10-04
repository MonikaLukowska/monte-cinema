class User < ApplicationRecord
  enum role: { client: 0, manager: 1 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates_with PasswordLengthValidator

  has_many :reservations, dependent: :destroy
end
