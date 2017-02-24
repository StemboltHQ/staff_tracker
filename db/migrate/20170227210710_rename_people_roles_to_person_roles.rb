class RenamePeopleRolesToPersonRoles < ActiveRecord::Migration[5.0]
  def change
    rename_table :people_roles, :person_roles
  end
end
