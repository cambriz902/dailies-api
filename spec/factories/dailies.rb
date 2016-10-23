# == Schema Information
#
# Table name: dailies
#
#  id                :integer          not null, primary key
#  daily_category_id :integer
#  title             :string
#  descriptions      :string
#  points            :integer          default(1)
#  last_completed    :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryGirl.define do
  factory :daily do
    
  end
end