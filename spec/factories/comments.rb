FactoryBot.define do
  factory :comment do
    user {  }
    post {  }
    body { "This is a comment!"}
    parent_id { nil }
  end
end
