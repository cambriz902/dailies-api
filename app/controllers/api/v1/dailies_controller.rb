class Api::V1::DailiesController < ApplicationController
  before_action :authenticate_with_token!, only: [:index]
  respond_to :json
  

  def index
    render json: current_user.dailies, status: 200
  end
end
