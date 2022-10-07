FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "testy#{n}@example.com" }
    password { 'password123' }
    confirmed_at { DateTime.now }

    factory :manager do
      role { :manager }
    end
  end
end
