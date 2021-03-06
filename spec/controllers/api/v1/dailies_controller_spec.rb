require 'spec_helper'

describe Api::V1::DailiesController, type: :controller do
  describe 'GET #index' do 
    before(:each) do
      current_user = FactoryGirl.create(:user)
      api_authorization_header current_user.auth_token
      daily_category = FactoryGirl.create(:daily_category, user: current_user)
      4.times { FactoryGirl.create(:daily, daily_category: daily_category) }
      get :index
    end

    it 'returns 4 dailies from the user' do
      dailies_response = json_response[:dailies]
      expect(dailies_response).to have(4).items
    end

    it { should respond_with 200 }
  end

  describe 'GET #show' do 
    before(:each) do
      current_user = FactoryGirl.create(:user)
      api_authorization_header current_user.auth_token
      daily_category = FactoryGirl.create(:daily_category, user: current_user)
      @daily = FactoryGirl.create(:daily, daily_category: daily_category)
      get :show, id: @daily.id
    end

    it 'returns the user daily matching the id' do
      daily_response = json_response[:daily]
      expect(daily_response[:id]).to eql(@daily.id)
    end

    it { should respond_with 200 }
  end

  describe 'POST #create' do
    before(:each) do 
      current_user = FactoryGirl.create(:user)
      api_authorization_header current_user.auth_token
      daily_category = FactoryGirl.create(:daily_category, user: current_user)
      daily_params = { 
        title: 'water', 
        description: 'drink 6 cups of water',
        daily_category_id: daily_category.id
      }
      post :create, daily: daily_params
    end

    it 'returns user daily record' do
      daily_response = json_response[:daily]
      expect(daily_response[:id]).to be_present
    end

    it { should respond_with 201 }
  end

  describe 'DELETE #destroy' do 
    before(:each) do
      current_user = FactoryGirl.create(:user)
      api_authorization_header current_user.auth_token
      daily = FactoryGirl.create(:daily)
      params = { id: daily.id }
      delete :destroy, params
    end

    it { should respond_with 204 }
  end

  describe 'PUT #complete' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @daily_category= FactoryGirl.create(:daily_category, user: @user)
      @daily = FactoryGirl.create(:daily, daily_category: @daily_category)
      api_authorization_header @user.auth_token
      params = { id: @daily.id }
      put :complete, params
    end

    context 'when succesful' do 
      it 'updates last_completed on Daily model' do
        prev_last_completed = @daily.last_completed
        @daily.reload
        expect(@daily.last_completed).to_not eql(prev_last_completed)
      end

      it 'increased DailyCategory total_points by 1' do 
        prev_total_points = @daily_category.total_points
        @daily_category.reload
        expect(prev_total_points + 1).to eql(@daily_category.total_points)
      end

      it { should respond_with 204 }
    end

    context 'when unsucessful' do
      before(:each) do
        @user = FactoryGirl.create(:user)
        @daily_category= FactoryGirl.create(:daily_category, user: @user)
        @daily = FactoryGirl.create(:daily, daily_category: @daily_category)
        api_authorization_header @user.auth_token
        put :complete, {id: (@daily.id + 1) }
      end

      it 'There was an error completing your daily' do 
        daily_response = json_response[:d]
        expect(json_response[:error]).to eql('There was an error completing your daily')
      end
      
      it { should respond_with 400 }
    end
  end
end
