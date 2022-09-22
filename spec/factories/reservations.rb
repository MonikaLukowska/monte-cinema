FactoryBot.define do
  factory :reservation do
    association :seance
    sequence(:email) { |n| "user#{n}@example.com" }
  end
end
