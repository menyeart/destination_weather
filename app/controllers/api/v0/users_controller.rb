class Api::V0::UsersController < ApplicationController
  def create
    if params[:password] == params[:password_confirmation]
      user = User.new(user_params)
      user.save!
      render json: UserSerializer.new(user), status: 201
    else
      render json: ErrorSerializer.new("Passwords do not match").invalid_request, status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
