class Presentation < ApplicationRecord
  belongs_to :person, optional: true
  belongs_to :event

  validates :topic,     presence: true
  validates :duration,  presence: true, numericality: true
  validates :person,    presence: true, unless: :presenter
  validates :presenter, presence: true, unless: :person
  validates :event,     presence: true

  validate  :person_or_presenter

  def presenter_name
    person ? person.first_name : presenter
  end

  private

  def person_or_presenter
    return unless person.present? && presenter.present?

    errors.add(:presenter, 'Can only have a Person or a Presenter')
  end
end
