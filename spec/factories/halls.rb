FactoryBot.define do
  factory :hall do
    sequence(:name) { |n| "Hall #{n} name" }
    capacity { 100 }
  end
end
