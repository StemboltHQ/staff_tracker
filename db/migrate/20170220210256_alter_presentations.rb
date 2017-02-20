class AlterPresentations < ActiveRecord::Migration[5.0]
  def change
    remove_column :presentations, :title, :string
    remove_column :presentations, :date_of_presentation, :date

    add_column :presentations, :subject, :string
    add_column :presentations, :date, :date
  end
end
