# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  auth_token             :string           default("")
#  time_zone              :string           default("")
#

require 'spec_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.create(:user, auth_token: 'auniquetoken1234') }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:auth_token) }
  
  it { should be_valid }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { should validate_confirmation_of(:password) }
  it { should validate_uniqueness_of(:auth_token) }
  it { should allow_value('example@domain.com').for(:email) } 

  it { should have_many(:daily_categories).dependent(:destroy) }
  it { should have_many(:dailies).through(:daily_categories) }

  describe '#generate_authentication_token!' do
    it 'generates a unique token' do
      Devise.stub(:friendly_token).and_return('auniquetoken123')
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql 'auniquetoken123'
    end

    it 'generates another token when one already has been taken' do
      existing_user = FactoryGirl.create(:user, auth_token: 'auniquetoken123')
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql(existing_user.auth_token)
    end
  end

  describe '#daily_categories association' do

    before do
      @user.save
      3.times { FactoryGirl.build :daily_category, user: @user }
    end

    it 'destroys the associated products on self destruct' do
      daily_categories = @user.daily_categories
      @user.destroy
      daily_categories.each do |daily_category|
        expect(DailyCategory.find(daily_category)).to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
