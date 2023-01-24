FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username }
  end

  factory :event do
    title { Faker::Esport.event }
    start_at { 1.hour.from_now }
    end_at { 2.hours.from_now }

    transient do
      creator { create(:user) }
    end

    after(:create) do |event, evaluator|
      event.invites.host.going.create!(user: evaluator.creator, inviter: evaluator.creator)
    end
  end
end
