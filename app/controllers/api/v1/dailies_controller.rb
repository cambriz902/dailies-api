class Api::V1::DailiesController < ApplicationController
  before_action :authenticate_with_token!, only: [:index]
  respond_to :json

  def index
    render json: current_user.dailies, status: 200
  end

  def show
    daily = current_user.dailies.find(params[:id])
    render json: daily, status: 200
  end

  def create
    daily = current_user
      .daily_categories
      .find(params[:daily_category_id])
      .dailies
      .build(daily_params)
    if daily.save
      render json: daily, status: 201, location: [:api, daily]
    else
      render json: { errors: daily.errors }, status: 422
    end
  end

  def destroy
    daily = Daily.find(params[:id])
    daily.destroy
    head 204
  end

  private

  def daily_params
    params.require(:daily).permit(:title, :description, :archived, :points)
  end
end
