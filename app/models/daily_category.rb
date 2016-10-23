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
  attr_accessor :user_id
  
  belongs_to :user
  has_many :dailies
end