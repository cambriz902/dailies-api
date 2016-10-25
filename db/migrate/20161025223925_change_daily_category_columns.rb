class ChangeDailyCategoryColumns < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:daily_categories, :total_points, 1)
  end
end
