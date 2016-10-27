# == Schema Information
#
# Table name: dailies
#
#  id                :integer          not null, primary key
#  daily_category_id :integer
#  title             :string           default("")
#  description       :text             default("")
#  points            :integer          default(1)
#  last_completed    :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class DailySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :points, :last_completed
end
