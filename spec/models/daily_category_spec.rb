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

require 'rails_helper'

describe DailyCategory do
  let(:daily_category) { FactoryGirl.build(:daily_category) }
  subject { daily_category }

  it { should respond_to(:kind) }
  it { should respond_to(:total_points) }
  it { should respond_to(:archived) }
  it { should respond_to(:user_id) }

  it { should validate_presence_of :kind }
  it { should validate_presence_of :total_points }
  it { should validate_numericality_of(:total_points).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of :user_id }

end
