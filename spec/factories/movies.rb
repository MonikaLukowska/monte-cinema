FactoryBot.define do
  factory :movie do
    sequence(:title) { |n| "Movie #{n} title" }
    length { 120 }
  end
end
