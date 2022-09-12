class Hall < ApplicationRecord
  validates :number, :capacity, presence: true
  validates :number, uniqueness: true
end
