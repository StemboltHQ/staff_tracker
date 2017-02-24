class Person < ApplicationRecord
  has_many :presentations

  before_save do
    email.downcase!
    gender.downcase!
  end

  valid_email_regex = /.+@.+\..+/i

  validates :first_name, length: { minimum: 2 }
  validates :first_name,
            presence: true,
            if: -> { new_record? || first_name.blank? }

  validates :email,
            presence: true,
            if: -> { new_record? || email.blank? }
  validates :email,
            format: { with: valid_email_regex }
  validates :email,
            uniqueness: { case_sensitive: false }

  validates :date_of_birth,
            presence: true,
            if: -> { new_record? || date_of_birth.blank? }

  validates :gender,
            presence: true,
            if: -> { new_record? || gender.blank? }

  has_secure_password
end
