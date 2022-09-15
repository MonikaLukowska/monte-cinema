class Movie < ApplicationRecord
  validates :title, :length, presence: true
end
