class Person < ApplicationRecord
  has_many :presentations

  before_save do
    email.downcase!
    gender.downcase!
  end

  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name,
            presence: true,
            length: { minimum: 2 },
            if: -> { new_record? || !first_name.nil? }
  validates :email,
            presence: true,
            format: { with: valid_email_regex },
            uniqueness: { case_sensitive: false },
            if: -> { new_record? || !email.nil? }
  validates :date_of_birth,
            presence: true,
            if: -> { new_record? || !date_of_birth.nil? }
  validates :gender,
            presence: true,
            if: -> { new_record? || !gender.nil? }
  validates :password,
            presence: true,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
  validates :password_confirmation,
            presence: true,
            length: { minimum: 6 },
            if: -> { new_record? || !password_confirmation.nil? }

  has_secure_password
end
