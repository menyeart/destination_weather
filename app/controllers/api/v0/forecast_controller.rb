class Api::V0::ForecastController < ApplicationController

  def index
    forecast = WeatherFacade.new(params[:location]).create_weather_obj
    render json: ForecastSerializer.new(forecast)
  end
end