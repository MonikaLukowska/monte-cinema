class Ticket < ApplicationRecord
  belongs_to :reservation

  validates :seat, presence: true
  validates_with SeatAvailabilityValidator

  delegate :seance, to: :reservation, allow_nil: true
end
