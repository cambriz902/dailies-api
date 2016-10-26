# == Schema Information
#
# Table name: daily_categories
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  kind         :string
#  total_points :integer          default(1)
#  archived     :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class DailyCategory < ApplicationRecord
  attr_accessor :user

  validates :kind, :total_points, :user_id, presence: true
  validates :total_points, numericality: { greater_than_or_equal_to: 0}, presence: true
  
  belongs_to :user
  has_many :dailies
end
