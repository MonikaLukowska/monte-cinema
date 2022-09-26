require 'uri'

class Reservation < ApplicationRecord
  belongs_to :seance
  has_many :tickets, dependent: :destroy

  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
