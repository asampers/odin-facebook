FactoryBot.define do
  factory :notification do
    user { nil }
    notifiable { nil }
    sender { nil }
  end
end
