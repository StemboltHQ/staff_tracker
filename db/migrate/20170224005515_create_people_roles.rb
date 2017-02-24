class CreatePeopleRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :people_roles do |t|
      t.belongs_to :person, index: true
      t.belongs_to :role, index: true

      add_foreign_key :people, :people_roles
      add_foreign_key :roles, :people_roles
    end
  end
end
