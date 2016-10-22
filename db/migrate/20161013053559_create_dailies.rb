class CreateDailies < ActiveRecord::Migration[5.0]
  def change
    create_table :dailies do |t|
      t.belongs_to :daily_category
      t.string :title
      t.string :descriptions
      t.integer :points, default: 1
      t.datetime :last_completed

      t.timestamps
    end
  end
end
