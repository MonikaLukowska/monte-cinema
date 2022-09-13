class Hall < ApplicationRecord
  validates :name, :capacity, presence: true
  validates :name, uniqueness: true
end
