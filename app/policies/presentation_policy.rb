class PresentationPolicy < ApplicationPolicy
  def create?
    person.present?
  end

  def new?
    create?
  end

  def update?
    (person&.admin? || person&.presentations&.include?(record)).present?
  end

  def edit?
    update?
  end
end
