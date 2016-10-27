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
end
