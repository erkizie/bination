FactoryBot.define do
  factory :article do
    title { "Factory title" }
    body { "Factory body" }
    description { "Factory description" }
    user { nil }
  end
end
