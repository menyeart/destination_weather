require "rails_helper"

RSpec.describe WeatherService do 
  before(:each) do 
    @service = WeatherService.new
  end

  describe "exists and has an api call", :vcr do 
    it "is a service" do 
      expect(@service).to be_a(WeatherService)
    end

    it "has a connection to faraday" do 
      expect(@service.conn).to be_a(Faraday::Connection)
    end

    it "returns a hash of current weather data" do 
      result = @service.current_weather("39.74001, -104.99202")

      expect(result).to be_a(Hash)
      expect(result).to have_key(:current)
      expect(result[:current]).to have_key(:last_updated)
      expect(result[:current][:last_updated]).to be_a(String)
      expect(result[:current]).to have_key(:temp_f)
      expect(result[:current][:temp_f]).to be_a(Float)
      expect(result[:current]).to have_key(:feelslike_f)
      expect(result[:current][:feelslike_f]).to be_a(Float)
      expect(result[:current]).to have_key(:humidity)
      expect(result[:current][:humidity]).to be_a(Integer)
      expect(result[:current]).to have_key(:uv)
      expect(result[:current][:uv]).to be_a(Float)
      expect(result[:current]).to have_key(:vis_miles)
      expect(result[:current][:vis_miles]).to be_a(Float)
      expect(result[:current]).to have_key(:condition)
      expect(result[:current][:condition]).to have_key(:text)
      expect(result[:current][:condition][:text]).to be_a(String)
      expect(result[:current][:condition]).to have_key(:icon)
      expect(result[:current][:condition][:icon]).to be_a(String)
      expect(result[:current][:last_updated]).to be_a(String)
      expect(result[:current][:condition]).to have_key(:icon)
    end

    it "returns a hash of daily weather data" do 
      result = @service.daily_weather("39.74001, -104.99202")

      expect(result).to be_a(Hash)
      expect(result).to have_key(:forecast)
      expect(result[:forecast][:forecastday]).to be_a(Array)
      result[:forecast][:forecastday].each do |day|
        expect(day).to have_key(:date)
        expect(day[:date]).to be_a(String)
        expect(day[:day]).to have_key(:maxtemp_f)
        expect(day[:day][:maxtemp_f]).to be_a(Float)
        expect(day[:day]).to have_key(:mintemp_f)
        expect(day[:day][:maxtemp_f]).to be_a(Float)
        expect(day[:day]).to have_key(:condition)
        expect(day[:day][:condition][:text]).to be_a(String)
        expect(day[:day][:condition][:icon]).to be_a(String)
        expect(day).to have_key(:astro)
        expect(day[:astro]).to have_key(:sunrise)
        expect(day[:astro][:sunrise]).to be_a(String)
        expect(day[:astro]).to have_key(:sunrise)
        expect(day[:astro][:sunset]).to be_a(String)
      end
    end
  end
end