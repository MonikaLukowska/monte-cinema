FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "testy#{n}@example.com" }
    password { 'password123' }
  end
end
