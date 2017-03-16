class PresentationPolicy < ApplicationPolicy
  def create?
    true
  end

  def new?
    create?
  end
end
