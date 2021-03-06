class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.date   :date_of_birth
      t.string :gender

      t.timestamps
    end
  end
end
