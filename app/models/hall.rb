class Hall < ApplicationRecord
  validates :name, :capacity, presence: true
  validates :name, uniqueness: true

  has_many :seances, dependent: :destroy

  def all_seats
    (1..capacity).to_a
  end
end
