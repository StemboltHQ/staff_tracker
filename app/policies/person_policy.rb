class PersonPolicy < ApplicationPolicy
  def admin?
    person.present? && person.admin?
  end
end
