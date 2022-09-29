FactoryBot.define do
  factory :reservation do
    association :seance
    association :user
  end
end
