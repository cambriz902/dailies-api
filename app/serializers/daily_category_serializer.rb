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

class DailyCategorySerializer < ActiveModel::Serializer
  attributes :id, :kind, :total_points
end
