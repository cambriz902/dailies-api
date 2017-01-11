class Api::V1::SessionsController < ApplicationController
  respond_to :json
  
  def create
    user_password = params[:session][:password]
    user_email = params[:session][:email].downcase
    user = user_email.present? && User.find_by(email: user_email)
    
    if !user.blank? && user.valid_password?(user_password)
      sign_in user, store: false
      user.generate_authentication_token!
      user.save!
      Time.use_zone(user.time_zone)  do
        render json: user, serializer: LoginUserSerializer , status: 200
      end
    else
      render json: { errors: 'Invalid email or password' }, status: 422
    end
  rescue
    render json: { errors: 'Invalid email or password' }, status: 422
  end

  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_authentication_token!
    user.save
    head 204
  end
end
