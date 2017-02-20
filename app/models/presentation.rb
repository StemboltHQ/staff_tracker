# app/models/presentation.rb
class Presentation < ApplicationRecord
  has_many :person_presentations
  has_many :people, through: :person_presentations

  validates :subject,
            presence: true,
            if: -> { new_record? || !subject.nil? }

  validates :content,
            presence: true,
            if: -> { new_record? || !content.nil? }

  validates :date,
            presence: true,
            if: -> { new_record? || !date.nil? }
end
