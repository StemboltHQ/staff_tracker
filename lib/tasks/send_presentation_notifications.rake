require 'rake'

desc 'Sends email notifications to all presenters of upcoming events'
task send_presentation_notifications: :environment do
  Event.requiring_notification.each do |event|
    EventNotificationJob.perform_later(event)
  end
end
