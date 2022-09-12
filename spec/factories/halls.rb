FactoryBot.define do
  factory :hall do
    sequence(:number) { |n| n }
    capacity { 100 }
  end
end
