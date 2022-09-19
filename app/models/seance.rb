class Seance < ApplicationRecord
  belongs_to :movie
  belongs_to :hall

  validates :start_time, :price, presence: true
  validates :start_time, :movie_length, availability: true

  delegate :length, to: :movie, prefix: true, allow_nil: true
  delegate :title, to: :movie, prefix: true, allow_nil: true

  scope :filtered_by_day, ->(date) { where('Date(start_time) = ?', date) }
end
