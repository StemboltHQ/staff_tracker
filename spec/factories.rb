# spec/factories.rb
FactoryGirl.define do
  factory :person do
    first_name 'John'
    last_name 'Doe'
    email { "john.doe#{Random.rand(1000)}@example.com" }
    password 'abc123'
    password_confirmation 'abc123'
    date_of_birth Date.new(1970, 1, 1)
    gender 'Computer'

    trait :admin do
      roles { build_list(:role, 1, :admin) }
    end
  end

  factory :event do
    name 'Show & Tell'
    location 'Board Room'
    date Date.new(2017, 2, 24)

    trait :requiring_notification do
      date Time.zone.today - Event::NOTIFICATION_PERIOD
    end

    trait :not_requiring_notification do
      date Time.zone.today + Event::NOTIFICATION_PERIOD
    end
  end

  factory :presentation do
    topic 'Being Awesome'
    description 'How to be awesome and stuff'
    duration 15
    person
    event

    trait :requiring_notification do
      event { FactoryGirl.build(:event, :requiring_notification) }
    end
  end

  factory :role do
    trait :admin do
      name :admin
    end
  end
end
