# Person Seeder
5.times do |i|
  Person.create!(
    first_name: 'Person',
    last_name: "#{i}",
    email: "person.#{i}@example.com",
    date_of_birth: Date.new(1970,1,1),
    password: 'abc123',
    password_confirmation: 'abc123',
    gender: 'Seed'
  )
end

# Event Seeder
Event.create!(
  date: Date.new(2017, 3, 1),
  location: 'Stembolt Offices',
  name: 'Show & Tell'
)
Event.create!(
  date: Date.new(2027, 1, 1),
  location: 'Stembolt - Mars Office',
  name: 'Show & Tell'
)

# Presentation Seeder
# 26 presentations to test pagination

26.times do |i|
  Presentation.create!(
    topic: "Presentation #{i}",
    description: 'Super awesome presentation',
    duration: 1,
    person_id: Person.pluck(:id).sample,
    event_id: Event.pluck(:id).sample
  )
end

6.times do |i|
  Presentation.create!(
    topic: "Presentation #{i}",
    description: 'Super awesome presentation',
    duration: 1,
    presenter: "Guest #{i}",
    event_id: Event.pluck(:id).sample
  )
end
