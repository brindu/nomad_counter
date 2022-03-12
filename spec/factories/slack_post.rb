FactoryBot.define do
  factory :slack_post do
    sequence(:external_id) { |n| "id_#{n}" }
    sequence(:team_id)     { |n| "team__#{n}" }
    sequence(:user_id)     { |n| "user_#{n}" }
    sequence(:channel_id)  { |n| "channel_{n}" }
    timestamp   { Faker::Time.backward }
    text { Faker::Hipster.paragraphs(number: 1).first }
  end

  trait :discarded do
    discarded { true }
  end

  trait :remaining do
    discarded { false }
  end

  trait :with_event do
    after(:create) do |post|
      create(:event, slack_post: post)
    end
  end
end
