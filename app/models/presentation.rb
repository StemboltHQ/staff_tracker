class Presentation < ApplicationRecord
  belongs_to :person, optional: true
  belongs_to :event

  validates :topic,     presence: true
  validates :person,    presence: true, unless: :presenter
  validates :presenter, presence: true, unless: :person
  validates :event,     presence: true
  validates :duration,  presence: true, numericality: {
    greater_than: 0, less_than_or_equal_to: 15
  }

  validate  :person_or_presenter
  validate  :associated_event_has_available_time

  def presenter_name
    person ? person.first_name : presenter
  end

  private

  def person_or_presenter
    return unless person.present? && presenter.present?

    errors.add(:presenter, 'Can only have a Person or a Presenter')
  end

  def associated_event_has_available_time
    return if duration.nil? ||
              event.nil? ||
              event.duration + duration <= Event::MAXIMUM_DURATION

    errors.add(
      :event,
      %(
        duration is #{event.duration}, adding presentation would overflow.
        Maximum event time is #{Event::MAXIMUM_DURATION} minutes.
      )
    )
  end
end
