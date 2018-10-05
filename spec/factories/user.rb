FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '123qwe' }
  end
end