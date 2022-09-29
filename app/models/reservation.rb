require 'uri'

class Reservation < ApplicationRecord
  CREATED = 'created'.freeze
  CONFIRMED = 'confirmed'.freeze
  CANCELLED = 'cancelled'.freeze
  RESERVATION_STATUSES = [CREATED, CONFIRMED, CANCELLED].freeze

  belongs_to :seance
  belongs_to :user
  has_many :tickets, dependent: :destroy

  validates :status, presence: true
end
