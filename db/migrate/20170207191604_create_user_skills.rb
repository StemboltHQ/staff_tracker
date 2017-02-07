class CreateUserSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :user_skills do |t|
      t.belongs_to :user, index: true
      t.belongs_to :language, index: true
    end
  end
end
