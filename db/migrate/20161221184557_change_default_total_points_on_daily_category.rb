class ChangeDefaultTotalPointsOnDailyCategory < ActiveRecord::Migration[5.0]
  def up
    change_column_default(:daily_categories, :total_points, 0)
  end

  def down 
    change_column_default(:dailies, :total_points, 1)
  end
end
