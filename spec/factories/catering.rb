FactoryBot.define do
  factory :catering do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { '123qwe' }
    city { Faker::Nation.capital_city }
    description { Faker::Lorem.paragraph }
  end
end