require 'spec_helper'

describe Api::V1::DailyCategoriesController do 
  describe 'GET #show' do
    before(:each) do
      @daily_category = FactoryGirl.create(:daily_category)
      get :show, id: @daily_category
    end

    it 'returns the information about a daily category on a hash' do
      category_response = json_response
      expect(category_response[:kind]).to eql(@daily_category.kind)
    end

    it { should respond_with 200 }
  end

  describe 'GET #index' do
    before(:each) do 
      4.times { FactoryGirl.create(:daily_category) }
      get :index
    end

    it 'returns 4 records from the database' do 
      categories_response = json_response
      expect(categories_response[:daily_categories]).to have(4).items
    end

    it { should respond_with 200 }
  end
end
