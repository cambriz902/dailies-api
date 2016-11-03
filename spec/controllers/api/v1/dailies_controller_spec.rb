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
        description: 'drink 6 cups of water' 
      }
      post :create, daily_category_id: daily_category.id, daily: daily_params
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
end
