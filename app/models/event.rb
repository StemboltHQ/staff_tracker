# app/models/event.rb
class Event < ApplicationRecord
  NOTIFICATION_PERIOD = 1.day
  MAXIMUM_DURATION = Figaro.env.maximum_event_duration.to_i
  has_many :presentations

  validates :date,
            presence: true
  validates :location,
            presence: true
  validates :name,
            presence: true

  scope :upcoming, -> { where('date >= ?', Time.zone.today) }
  scope :requiring_notification, -> do
    where('date = ?', Date.current - NOTIFICATION_PERIOD)
  end

  def duration
    presentations.map(&:duration).sum
  end
end
