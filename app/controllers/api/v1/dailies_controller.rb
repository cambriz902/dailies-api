class Api::V1::DailiesController < ApplicationController
  respond_to :json
  before_action :authenticate_user!

  def show
    respond_with User.where()
  end

  def create

  end

  def category_dailies
   respond_with Daily.where(daily_categories_id: params[:daily_categories_id])
  end
end
