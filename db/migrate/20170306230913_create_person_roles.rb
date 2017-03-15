class CreatePersonRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :person_roles do |t|
      t.references :person, index: true
      t.references :role, index: true
    end
    add_foreign_key :person_roles, :people
    add_foreign_key :person_roles, :roles
  end
end
