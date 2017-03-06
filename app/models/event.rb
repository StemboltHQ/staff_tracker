# app/models/event.rb
class Event < ApplicationRecord
  NOTIFICATION_PERIOD = 1.day
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
