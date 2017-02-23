# app/models/event.rb
class Event < ApplicationRecord
  has_many :presentations

  validates :date,
            presence: true
  validates :location,
            presence: true
  validates :name,
            presence: true
end
