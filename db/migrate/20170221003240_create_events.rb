class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.date :date
      t.string :location
      t.string :name

      t.timestamps
    end
  end
end
