class Seance < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  has_many :reservations, dependent: :destroy
  has_many :tickets, through: :reservations

  validates :start_time, :price, presence: true
  validates :start_time, :movie_length, availability: true

  delegate :length, to: :movie, prefix: true, allow_nil: true
  scope :filtered_by_day, ->(date) { where('Date(start_time) = ?', date) }

  def seats_availability
    hall.all_seats.map do |seat|
      status = taken_seats.include?(seat) ? 'reserved' : 'available'
      { seat: seat, status: status }
    end
  end

  def taken_seats
    tickets.pluck(:seat)
  end
end
