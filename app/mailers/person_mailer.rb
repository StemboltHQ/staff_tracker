class PersonMailer < ApplicationMailer
  include ActionView::Helpers::DateHelper
  def presentation_notification(presenter, event_date)
    @presenter = presenter
    @event_date = event_date.strftime('%a %b %d')
    @notification_period = distance_of_time_in_words(
      Event::NOTIFICATION_PERIOD
    )
    mail(
      to: presenter.email,
      subject: "You have a presentation in #{@notification_period}"
    )
  end
end
