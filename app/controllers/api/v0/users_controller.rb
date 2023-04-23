class Api::V0::UsersController < ApplicationController

  def create
    if params[:password] == params[:password_confirmation]
      user = User.new(user_params)
      user.save!
      render json: UserSerializer.new(user)
    else
      render ErrorSerializer.new(user.errors.full_message.join)
    end 
  end

private

  def user_params
    params.permit(:email, :password)
  end
end