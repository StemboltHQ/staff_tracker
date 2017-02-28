class PersonRole < ApplicationRecord
  belongs_to :person
  belongs_to :role

  validates :people, :roles, presence: true
end
