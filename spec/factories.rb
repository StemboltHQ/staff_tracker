# spec/factories.rb
FactoryGirl.define do
  factory :person do
    first_name 'John'
    last_name 'Doe'
    email "john.doe#{Random.rand(1000)}@example.com"
    password 'abc123'
    password_confirmation 'abc123'
    date_of_birth Date.new(1970, 1, 1)
    gender 'Computer'
  end

  factory :presentation do
    topic 'Being Awesome'
    description 'How to be awesome and stuff'
    duration 900
    person
    event
  end

  factory :event do
    name 'Show & Tell'
    location 'Board Room'
    date Date.new(2017, 2, 24)
  end

  factory :role do
    name 'Admin'
  end
end
