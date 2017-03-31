class PersonPolicy < ApplicationPolicy
  def admin?
    signed_in?(person) && person.admin?
  end
end
