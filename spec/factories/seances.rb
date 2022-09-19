FactoryBot.define do
  factory :seance do
    association :movie
    association :hall
    start_time { Time.zone.now }
    price { 15 }
  end
end
