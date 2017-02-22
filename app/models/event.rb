# app/models/event.rb
class Event < ApplicationRecord
  validates :date,
            presence: true
  validates :location,
            presence: true
  validates :name,
            presence: true
end
