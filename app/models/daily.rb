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

class Daily < ApplicationRecord
  validates :daily_category_id, :title, :description, presence: true
  validates :points, presence: true,
                    numericality: { greater_than_or_equal_to: 1 }

  belongs_to :daily_category
end
