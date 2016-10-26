class Api::V1::DailyCategoriesController < ApplicationController
  respond_to :json

  def index
    daily_categories = DailyCategory.all
    render json: daily_categories, status: 200
  end
  
  def show
    daily_category = DailyCategory.find(params[:id])
    render json: daily_category, status: 200
  end
  
end
