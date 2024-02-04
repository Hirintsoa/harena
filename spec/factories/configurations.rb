FactoryBot.define do
  factory :configuration do
    category { "Income" }
    name { "Default name" }
    base { "day" }
    range_amount { 1 }
    amount { Faker::Commerce.price(range: 400..1800.0) }
    automatic { true }
    preferred_day { "2024-02-05" }
  end
end
