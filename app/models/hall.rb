class Hall < ApplicationRecord
  validates :name, :capacity, presence: true
  validates :name, uniqueness: true

  has_many :seances, dependent: :destroy
end
