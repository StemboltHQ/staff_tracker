class Role < ApplicationRecord
  has_many :person_roles
  has_many :people, through: :person_roles

  enum name: { admin: 0 }
end
