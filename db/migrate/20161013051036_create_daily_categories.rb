class CreateDailyCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :daily_categories do |t|
      t.belongs_to :user
      t.string :kind
      t.integer :total_points, default: 0
      t.boolean :archived, default: false

      t.timestamps
    end
  end
end
