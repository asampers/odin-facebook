FactoryBot.define do
  factory :profile do
    user { nil }
    full_name { "MyString" }
    age { 1 }
    location { "MyString" }
    bio { "MyText" }
  end
end
