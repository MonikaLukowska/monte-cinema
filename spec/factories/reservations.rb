FactoryBot.define do
  factory :reservation do
    association :seance
    association :user

    trait :created do
      status { Reservation::CREATED }
    end
  end
end
