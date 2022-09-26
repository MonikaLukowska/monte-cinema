FactoryBot.define do
  factory :ticket do
    seat { rand(1..100) }
    association :reservation
  end
end
