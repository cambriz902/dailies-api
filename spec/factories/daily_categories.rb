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

FactoryGirl.define do
  factory :daily_category do
    kind 'health'
    total_points 0
    archived false
    user
  end
end
