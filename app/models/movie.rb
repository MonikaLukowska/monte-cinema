class Movie < ApplicationRecord
  validates :title, :length, presence: true

  has_many :seances, dependent: :destroy
end
