FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Test Project #{n}" }
    description 'Sample project for testing purposes'
    due_on 1.week.from_now
    association :owner

  # 昨日が締め切のプロジェクト
  trait :due_yesterday do
    due_on 1.day.ago
  end

  # 今日が締切のプロジェクト
   trait :due_today do
    due_on Data.current.in_time_zone
  end

  # 明日が締切のプロジェクト
   trait :due_tomorrow do
    due_on 1.day.from_now
   end
  end
end
