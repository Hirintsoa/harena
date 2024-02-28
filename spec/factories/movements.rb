FactoryBot.define do
  factory :movement do
    type { 'Income' }
    name { Faker::Name.first_name }
    description { Faker::Lorem.sentence }
    amount { Faker::Commerce.price(range: 500..7000.0) }
    activity
  end
end
