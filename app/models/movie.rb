class Movie < ApplicationRecord
  validates :title, :length, presence: true

  has_many :seances, dependent: :destroy

  scope :fetch_by_day, ->(date) { where(seances: { start_time: date.to_date.all_day }) }
end
