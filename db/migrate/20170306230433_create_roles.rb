class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.column :name, :integer

      t.timestamps
    end
  end
end
