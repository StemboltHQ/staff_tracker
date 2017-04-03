class Person < ApplicationRecord
  has_many :presentations
  has_many :person_roles
  has_many :roles, through: :person_roles

  before_save do
    email.downcase!
    gender&.downcase!
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

  has_secure_password

  def admin?
    roles.detect(&:admin?).present?
  end

  def toggle_admin!
    admin_role = Role.find_or_create_by(name: 'admin')
    if admin?
      roles.delete(admin_role)
    else
      roles << admin_role
    end
    roles
  end
end
