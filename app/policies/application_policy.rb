class ApplicationPolicy
  attr_reader :person, :record

  def initialize(person, record)
    @person = person || Person.new
    @record = record
  end

  def create?
    signed_in?(person) && person.admin?
  end

  def new?
    create?
  end

  def update?
    signed_in?(person) && person.admin?
  end

  def edit?
    update?
  end

  def destroy?
    signed_in?(person) && person.admin?
  end

  private

  def signed_in?(person)
    person.persisted?
  end
end
