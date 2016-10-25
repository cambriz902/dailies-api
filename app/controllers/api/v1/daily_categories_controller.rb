class Api::V1::DailyCategoriesController < ApplicationController
  respond_to :json
  before_action :authenticate_user!

  def show
   
  end

  def create
    category = DailyCategory.new(daily_category_params)
    category.update(user_id: 1)
    if category.save
      respond_with(data: category, status: 201)
    else
      respond_with(error: category.errors, status: 422)
    end
  end

  def user_daily_categories
    respond_with DailyCategory.where(user_id: params[:user_id])
  end

  private

  def daily_category_params
    params.require(:daily_category).permit(:kind)
  end
  
end
