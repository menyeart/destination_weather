require "rails_helper"

RSpec.describe WeatherFacade do
  before(:each) do
    @facade = WeatherFacade.new("Denver, CO")
  end

  describe "Weather Facade", :vcr do
    it "exists" do
      expect(@facade).to be_a(WeatherFacade)
    end

    it "creates a weather object with attributes" do
      forecast = @facade.create_weather_obj
      current_keys = [:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon]
      daily_keys = [:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon]
      hourly_keys = [:time, :temperature, :conditions, :icon]

      expect(forecast).to be_a(WeatherForecast)

      expect(forecast.current_weather.keys).to eq(current_keys)
      expect(forecast.current_weather[:last_updated]).to be_a(String)
      expect(forecast.current_weather[:temperature]).to be_a(Float)
      expect(forecast.current_weather[:feels_like]).to be_a(Float)
      expect(forecast.current_weather[:humidity]).to be_a(Integer)
      expect(forecast.current_weather[:uvi]).to be_a(Float)
      expect(forecast.current_weather[:visibility]).to be_a(Float)
      expect(forecast.current_weather[:condition]).to be_a(String)
      expect(forecast.current_weather[:icon]).to be_a(String)

      expect(forecast.daily_weather).to be_a(Array)
      forecast.daily_weather.each do |day|
        expect(day.keys).to eq(daily_keys)
        expect(day[:date]).to be_a(String)
        expect(day[:sunrise]).to be_a(String)
        expect(day[:sunset]).to be_a(String)
        expect(day[:max_temp]).to be_a(Float)
        expect(day[:min_temp]).to be_a(Float)
        expect(day[:condition]).to be_a(String)
        expect(day[:icon]).to be_a(String)
      end

      expect(forecast.hourly_weather).to be_a(Array)
      forecast.hourly_weather.each do |hour|
        expect(hour.keys).to eq(hourly_keys)
        expect(hour[:time]).to be_a(String)
        expect(hour[:temperature]).to be_a(Float)
        expect(hour[:conditions]).to be_a(String)
        expect(hour[:icon]).to be_a(String)
      end
    end

    it "extracts current weather information" do
      weather = @facade.current
      keys = [:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon]

      expect(weather).to be_a(Hash)
      expect(weather.keys).to eq(keys)
      expect(weather[:last_updated]).to be_a(String)
      expect(weather[:temperature]).to be_a(Float)
      expect(weather[:feels_like]).to be_a(Float)
      expect(weather[:uvi]).to be_a(Float)
      expect(weather[:visibility]).to be_a(Float)
      expect(weather[:condition]).to be_a(String)
      expect(weather[:icon]).to be_a(String)
    end

    it "extracts and formats daily weather information" do
      weather = @facade.daily
      keys = [:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon]

      expect(weather).to be_a(Array)
      weather.each do |day|
        expect(day.keys).to eq(keys)
        expect(day[:date]).to be_a(String)
        expect(day[:sunrise]).to be_a(String)
        expect(day[:sunset]).to be_a(String)
        expect(day[:max_temp]).to be_a(Float)
        expect(day[:min_temp]).to be_a(Float)
        expect(day[:condition]).to be_a(String)
        expect(day[:icon]).to be_a(String)
      end
    end

    it "extracts and formats hourly weather information" do
      weather = @facade.hourly
      keys = [:time, :temperature, :conditions, :icon]

      expect(weather).to be_a(Array)
      expect(weather.count).to eq(24)
      weather.each do |day|
        expect(day.keys).to eq(keys)
        expect(day[:time]).to be_a(String)
        expect(day[:temperature]).to be_a(Float)
        expect(day[:conditions]).to be_a(String)
        expect(day[:icon]).to be_a(String)
      end
    end
  end
end
