class AddTimeZoneToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :time_zone, :string, default: ''
  end
end
