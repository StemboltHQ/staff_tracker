# app/models/event.rb
class Event < ApplicationRecord
  NOTIFICATION_PERIOD = 1.days
  validates :date,
            presence: true
  validates :location,
            presence: true
  validates :name,
            presence: true

  def notification_necessary?
    date - NOTIFICATION_PERIOD < Date.today
  end
end
