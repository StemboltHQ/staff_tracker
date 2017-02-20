# spec/factories.rb
FactoryGirl.define do
  factory :person do
    first_name 'John'
    last_name 'Doe'
    sequence :email do |n|
      "john.doe.#{n}@example.com"
    end
    password 'abc123'
    password_confirmation 'abc123'
    date_of_birth Date.new(1970, 1, 1)
    gender 'Computer'
  end

  factory :presentation do
    subject 'Test Presentation'
    content 'Lorem ipsum dolor'
    date Date.new(2017, 2, 18)
  end
end
