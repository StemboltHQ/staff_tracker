class ApplicationPolicy
  attr_reader :person, :record

  def initialize(person, record)
    @person = person
    @record = record
  end

  def create?
    person.present? && person.admin?
  end

  def new?
    create?
  end

  def update?
    person.present? && person.admin?
  end

  def edit?
    update?
  end

  def destroy?
    person.present? && person.admin?
  end
end
