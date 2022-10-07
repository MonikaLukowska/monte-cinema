FactoryBot.define do
  factory :seance do
    association :movie
    association :hall
    start_time { DateTime.now }
    price { 15 }
  end
end
