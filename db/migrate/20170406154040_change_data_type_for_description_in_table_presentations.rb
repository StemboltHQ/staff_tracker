class ChangeDataTypeForDescriptionInTablePresentations < ActiveRecord::Migration[5.0]
  def change
    change_column :presentations, :description, :text
  end
end
