class Api::V0::RoadTripController < ApplicationController

  def create
    user = User.find_by(api_key: params[:api_key])
    if user != nil
      trip = RoadTripFacade.new(params[:origin], params[:destination]).create_road_trip 
      render json: RoadTripSerializer.new(trip), response: 200
    else
      render json: ErrorSerializer.new("Invalid token").invalid_request, status: 404
    end
  end
end