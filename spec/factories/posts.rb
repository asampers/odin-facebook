FactoryBot.define do
  factory :post do
    body { "This is a post body." }
    user { :faker }
  end
end
