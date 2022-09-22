class Reservation < ApplicationRecord
  belongs_to :seance
  has_many :tickets, dependent: :destroy

  validates :email, presence: true
end
