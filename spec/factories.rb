FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username(specifier: 5) }
  end

  factory :event do
    title { Faker::Esport.event }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    start_at { 1.hour.from_now }
    end_at { 2.hours.from_now }

    transient do
      creator { create(:user) }
    end

    after :create do |event, evaluator|
      event.invites.host.going.create!(user: evaluator.creator, inviter: evaluator.creator)
    end
  end

  factory :invite do
    user { create(:user) }
    event { create(:event) }

    trait :self_invite do
      before :create do |invite|
        invite.inviter = invite.user
      end
    end
  end
end
