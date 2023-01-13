FactoryBot.define do
  factory :comment do
    user { :jane }
    post { nil }
    parent_id { 1 }
  end
end
