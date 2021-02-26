FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@gmail.com" }
    sequence(:username) { |n| "simpleuser#{n}" }
    sequence(:password) { "qwerty123" }
  end
end