class AlterPresentations < ActiveRecord::Migration[5.0]
  def change
    remove_column :presentations, :date_of_presentation, :date

    rename_column :presentations, :title, :topic
    rename_column :presentations, :content, :description

    add_column :presentations, :presenter, :string
    add_column :presentations, :duration, :integer

    add_reference :presentations, :person, index: true
    add_reference :presentations, :event, index: true
  end
end
