module Admin
  class PeopleController < AdminController
    def index
      @people = Person.all
    end
  end
end
