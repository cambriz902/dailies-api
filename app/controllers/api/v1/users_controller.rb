class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:authenticated_user, :update, :destroy]
  respond_to :json

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201
    else
      render json: { errors: user.errors.messages }, status: 422
    end
  rescue
    render json: { errors: user.errors.messages }, status: 422
  end

  def update
    user = current_user

    if user.update(user_params)
      render json: user, status: 200
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    current_user.destroy!
    head 204
  end

  def authenticated_user
    render json: current_user, status: 200
  end
  
  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :time_zone)
  end
end
