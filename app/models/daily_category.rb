# == Schema Information
#
# Table name: daily_categories
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  kind         :string
#  total_points :integer          default(0)
#  archived     :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class DailyCategory < ApplicationRecord
  validates :kind, :total_points, :user_id, presence: true
  validates :archived, inclusion: [true, false]
  validates :total_points, numericality: { greater_than_or_equal_to: 0 }, presence: true
  
  belongs_to :user
  has_many :dailies, dependent: :destroy
  has_many :today_dailies, -> { not_completed }, class_name: 'Daily'

end
