module Admin
  class PeopleController < AdminController
    def index
      @people = Person.all
    end

    def batch_update
      changes_made = false
      people_params.each do |param|
        person = Person.find(param[:id])
        next if person.admin? == param[:admin]
        person.toggle_admin!
        changes_made = true
      end
      if changes_made
        flash[:success] = 'Admin users successfully updated'
      else
        flash[:error] = 'No changes to admin users were made'
      end
      redirect_to admin_people_path
    end

    private

    def people_params
      params.require(:people).map do |_person, param|
        {
          id: param[:id],
          admin: param[:admin] == '0' ? false : true
        }
      end
    end
  end
end
