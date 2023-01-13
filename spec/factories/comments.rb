FactoryBot.define do
  factory :comment do
    user { nil }
    post { nil }
    parent_id { 1 }
  end
end
