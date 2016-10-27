class UpdatesToDailyDescriptionsColumnsAndDefaultValues < ActiveRecord::Migration[5.0]
  def change
    rename_column :dailies, :descriptions, :description
    change_column :dailies, :description, :text, default: ''
    change_column :dailies, :title, :string, default: ''
  end
end
