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

  def create
    daily_category = current_user.daily_categories.build(daily_category_params)
    if daily_category.save
      render json: daily_category, status: 201, location: [:api, daily_category]
    else
      render json: { errors: daily_category.errors }, status: 422
    end
  end

  private

  def daily_category_params
    params.require(:daily_category).permit(:kind, :total_points, :archived)
  end
end
