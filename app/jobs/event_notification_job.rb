class EventNotificationJob < ApplicationJob
  def self.perform(event)
    event.presentations.joins(:person).each do |presentation|
      PersonMailer.presentation_notification(
        presentation.person,
        presentation.event.date
      ).deliver
    end
  end
end
