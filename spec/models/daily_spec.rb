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

require 'spec_helper'

describe Daily do
  let(:daily) { FactoryGirl.build :daily }
  subject { daily }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:points) }
  it { should respond_to(:last_completed) }

  it { should validate_presence_of :daily_category_id }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_numericality_of(:points).is_greater_than_or_equal_to(1) }

  it { should belong_to :daily_category }

  describe '#not_completed' do 
    before(:each) { Timecop.freeze }
    after(:each) { Timecop.return }

    it 'returns dailies with last_completed nil' do
      FactoryGirl.create(:daily, last_completed: nil)
      expect(Daily.not_completed.count).to eql(1)
    end

    it 'return dailies with last_completed not today' do
      FactoryGirl.create(:daily, last_completed: DateTime.current.yesterday)
      expect(Daily.not_completed.count).to eql(1)
    end

    it "doesn't return dailies completed today" do
      FactoryGirl.create(:daily, last_completed: DateTime.current)
      expect(Daily.not_completed.count).to eql(0)
    end
  end
end
