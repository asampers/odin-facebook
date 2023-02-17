FactoryBot.define do
  factory :user do
    username { 'User' }
    email { 'email@email.com' }
    password { 'password' }
    id { 1 }
  
  
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

    trait :author do 
      username { 'Sarah'}
      email { 'sara@sara.com' }
      password { 'password' }
      id { 202 }
    end 
  end
end
