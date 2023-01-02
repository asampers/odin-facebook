FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    id { Integer }
  end
end
