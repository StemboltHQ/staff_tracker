module Admin
  class PeopleController < AdminController
    def index
      @people = Person.all
    end

    def batch_update
      if Person.update(person_params.keys, person_params.values)
        flash[:success] = 'People successfully updated.'
      end
      redirect_to admin_people_path
    end

    private

    def person_params
      params.require(:people).permit(person: [role_ids: []])[:person]
    end
  end
end
