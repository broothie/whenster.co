FactoryBot.define do
  factory :user do
    email { Faker::Internet.safe_email }
    username { Faker::Internet.username(specifier: 5) }
  end

  factory :event do
    title { Faker::Esport.event }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    start_at { 1.hour.from_now }
    end_at { 2.hours.from_now }
    location { Faker::Address.city }
    place_id { Faker::Internet.base64 }

    transient do
      creator { create(:user) }
      invites { [] }
    end

    after :create do |event, evaluator|
      event.invites.host.going.create!(user: evaluator.creator, inviter: evaluator.creator)

      if evaluator.invites.any?
        evaluator.invites.each { |invite| invite[:inviter] ||= evaluator.creator }
        event.invites.create!(evaluator.invites)
      end
    end
  end

  factory :invite do
    user
    event
    inviter factory: :user

    trait :self_invite do
      before :create do |invite|
        invite.inviter = invite.user
      end
    end
  end

  factory :post do
    invite
    body { Faker::Lorem.paragraph(sentence_count: 3) }
  end

  factory :comment do
    invite
    post
    body { Faker::Lorem.paragraph(sentence_count: 3) }
  end
end
