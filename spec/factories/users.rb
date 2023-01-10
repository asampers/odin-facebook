FactoryBot.define do
  factory :user do
    trait :faker do 
      username { Faker::Internet.username }
      email { Faker::Internet.email }
      password { Faker::Internet.password }
      id { Integer }
    end

    trait :jane do 
      username { 'Jane' }
      email { 'jane@jane.com' }
      password { 123456 }
      id { 200 }
    end  

    trait :john do 
      username { 'John' }
      email { 'john@john.com' }
      password { 123456 }
      id { 201 } 
    end  
  end
end
