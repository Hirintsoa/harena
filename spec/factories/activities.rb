FactoryBot.define do
  factory :activity do
    name { "Default name" }
    description { Faker::Lorem.sentence }
    start_date { "2024-02-01" }
    balance { Faker::Commerce.price(range: 500..30000.0) }
  end
end
