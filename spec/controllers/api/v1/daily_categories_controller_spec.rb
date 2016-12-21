require 'spec_helper'

describe Api::V1::DailyCategoriesController do 
  describe 'GET #show' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      api_authorization_header(@user.auth_token)
      @daily_category = FactoryGirl.create(:daily_category, user: @user)
      get :show, id: @daily_category
    end

    it 'returns the information about a daily category in a hash' do
      daily_category_response = json_response[:daily_category]
      expect(daily_category_response[:kind]).to eql(@daily_category.kind)
    end

    it { should respond_with 200 }
  end

  describe 'GET #index' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      api_authorization_header(@user.auth_token)
      4.times { FactoryGirl.create(:daily_category, user: @user) }
    end

    context 'when not receiving any daily_category_ids parameter' do
      before(:each) do
        get :index
      end

      it 'returns 4 daily_categories records from the database' do 
        daily_categories_response = json_response[:daily_categories]
        expect(daily_categories_response).to have(4).items
      end

      it { should respond_with 200 }
    end

    context 'when daily_category_ids parameter is present' do
      before(:each) do
        @user = FactoryGirl.create(:user)
        api_authorization_header @user.auth_token
        3.times { FactoryGirl.create(:daily_category, user: @user) }
        2.times { FactoryGirl.create(:daily_category)}
        get :index, daily_category_ids: @user.daily_category_ids
      end

      it 'returns the daily_categories that belong to the user' do
        daily_category_ids_response = json_response[:daily_categories].pluck(:id)
        user_daily_category_ids = @user.daily_category_ids
        expect(daily_category_ids_response).to match_array(user_daily_category_ids)
      end

      it { should respond_with 200 }
    end
  end

  describe 'POST #create' do
    context 'when is successfully created' do
      before(:each) do
        user = FactoryGirl.create(:user)
        @daily_category_attributes = FactoryGirl.attributes_for(:daily_category)
        api_authorization_header user.auth_token
        post :create, { daily_category: @daily_category_attributes }
      end

      it 'renders the json representation for the daily_category record created' do
        daily_category_response = json_response[:daily_category]
        expect(daily_category_response[:kind]).to eql(@daily_category_attributes[:kind])
      end

      it { should respond_with 201 }
    end

    context 'when is not created' do 
      before(:each) do
        user = FactoryGirl.create(:user)
        @invalid_daily_category_attributes = 
          { archived: false }
        api_authorization_header user.auth_token
        post :create, { daily_category: @invalid_daily_category_attributes }
      end

      it 'renders json errors' do 
        daily_category_response = json_response
        expect(daily_category_response).to have_key(:errors)
      end

      it 'renders json errors on why the user could not be created' do
        daily_category_response = json_response
        expect(daily_category_response[:errors][:kind]).to include("can't be blank")
      end

      it { should respond_with 422 }
    end
  end

  describe 'PUT/PATCH #update' do 
    before(:each) do
      @user = FactoryGirl.create(:user)
      @daily_category = FactoryGirl.build(:daily_category)
      @daily_category.user = @user
      @daily_category.save!
      api_authorization_header @user.auth_token
    end

    context 'when is successfully updated' do
      before(:each) do
        patch :update, { id: @daily_category.id ,
              daily_category: { kind: 'web-development' } }
      end

      it 'renders json representation for the udpated daily_category' do
        daily_category_response = json_response[:daily_category]
        expect(daily_category_response[:kind]).to eql('web-development')
      end

      it { should respond_with 200 }
    end

    context 'when update is not succesful' do
      before(:each) do
        patch :update, { id: @daily_category.id,
              daily_category: { kind: nil} }
      end

      it 'renders json errors' do
        daily_category_response = json_response
        expect(daily_category_response). to have_key(:errors)
      end

      it 'renders the json errors on why the daily_category did not update' do
        daily_category_response = json_response
        expect(daily_category_response[:errors][:kind]). to include("can't be blank")
      end

      it { should respond_with 422 }
    end
  end

  describe 'DELETE #destroy' do 
    before(:each) do 
      @user = FactoryGirl.create(:user)
      @daily_category = FactoryGirl.create(:daily_category, user: @user)
      api_authorization_header @user.auth_token
      delete :destroy, { id: @daily_category.id }
    end

    it { should respond_with 204 }
  end
end
