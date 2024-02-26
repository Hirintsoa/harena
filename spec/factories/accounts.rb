FactoryBot.define do
  factory :account do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { Faker::Internet.password(min_length: 8, max_length: 18) }
    country { Faker::Address.country }
    lang { Faker::Address.country_code }
    picture { Faker::Avatar.image }
    mail_notifications { Faker::Boolean.boolean(true_ratio: 0.15) }
  end
end
