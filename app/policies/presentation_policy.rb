class PresentationPolicy < ApplicationPolicy
  def create?
    signed_in?(person)
  end

  def new?
    create?
  end

  def update?
    person.admin? || person.presentations.include?(record)
  end

  def edit?
    update?
  end
end
