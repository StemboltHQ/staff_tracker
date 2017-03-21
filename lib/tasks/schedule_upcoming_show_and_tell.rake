require 'rake'

desc 'Creates show and tell events for four weeks'
task populate_upcoming_show_and_tell: :environment do
  EventSchedule.populate_upcoming_show_and_tell!
end
