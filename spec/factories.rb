# spec/factories.rb
FactoryGirl.define do
  factory :person do
    first_name 'John'
    last_name 'Doe'
    sequence :email do |n|
      "john.doe.#{n}@example.com"
    end
    password "abc123"
    password_confirmation "abc123"
    date_of_birth Date.new(1970,01,01)
    gender "Computer"
  end

  factory :presentation do
    title "Test Presentation"
    content "Lorem ipsum dolor"
    date_of_presentation Date.new(2017,02,18)
  end
end
