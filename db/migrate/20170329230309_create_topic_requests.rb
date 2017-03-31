class CreateTopicRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :topic_requests do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
