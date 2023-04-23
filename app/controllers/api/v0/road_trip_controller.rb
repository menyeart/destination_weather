class Api::V0::RoadTripController < ApplicationController

  def create
    trip = RoadTripFacade.new(params[:origin], params[:destination]).create_road_trip 
    render json: RoadTripSerializer.new(trip)
  end
end