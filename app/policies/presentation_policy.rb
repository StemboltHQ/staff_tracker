class PresentationPolicy < ApplicationPolicy
  def create?
    person.present?
  end

  def new?
    create?
  end
end
