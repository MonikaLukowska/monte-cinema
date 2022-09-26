require 'uri'

class Reservation < ApplicationRecord
  CREATED = 'created'.freeze
  CONFIRMED = 'confirmed'.freeze
  CANCELLED = 'cancelled'.freeze
  RESERVATION_STATUSES = [CREATED, CONFIRMED, CANCELLED].freeze

  belongs_to :seance
  has_many :tickets, dependent: :destroy

  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
