class Role < ApplicationRecord
  has_many :person_roles
  has_many :people, through: :person_roles

  before_save { name.downcase! }

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }
end
