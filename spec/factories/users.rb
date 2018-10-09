FactoryBot.define do
  factory :user, aliases: [:owner] do
    first_name 'Haku'
    last_name 'Otter'
    sequence(:email) { |n| "haku#{n}@example.com" }
    password 'passpass'
  end
end
