require "rails_helper"

RSpec.describe RoadTripFacade do
  before(:each) do
    @facade = RoadTripFacade.new("Los Angeles, CA", "New York City, NY")
  end
  describe "Road Trip Facade", :vcr do
    it "exists" do
      expect(@facade).to be_a(RoadTripFacade)
    end

    it "creates a road trip object with attributes" do
      trip = @facade.create_road_trip

      expect(trip).to be_a(RoadTrip)
      expect(trip.end_city).to eq("New York City, NY")
      expect(trip.start_city).to eq("Los Angeles, CA")
      expect(trip.travel_time).to be_a(String)
      expect(trip.weather_at_eta).to be_a(Hash)
      expect(trip.weather_at_eta.keys).to eq([:datetime, :temperature, :condition])
      expect(trip.weather_at_eta[:datetime]).to be_a(String)
      expect(trip.weather_at_eta[:temperature]).to be_a(Float)
      expect(trip.weather_at_eta[:condition]).to be_a(String)
    end

    it "finds the seconds elapsed in a day so far" do
      seconds = @facade.seconds_elapsed_today

      expect(seconds).to be_a(Float)
    end

    it "extracts a lat/long string from the location service data" do
      string = @facade.extract_location

      expect(string).to be_a(String)
      expect(string).to eq("40.71453, -74.00712")
    end

    it "extracts the necessary weather fields from the weather service" do
      weather = @facade.get_destination_weather

      expect(weather).to be_a(Hash)
      expect(weather.keys).to eq([:datetime, :temperature, :condition])
      expect(weather[:datetime]).to be_a(String)
      expect(weather[:temperature]).to be_a(Float)
      expect(weather[:datetime]).to be_a(String)
    end

    it "extracts the necessary travel fields from the direction service" do
      info = @facade.get_travel_info

      expect(info).to be_a(Hash)
      expect(info.keys).to eq([:time, :formattedTime, :distance])
      expect(info[:time]).to be_a(Integer)
      expect(info[:formattedTime]).to be_a(String)
      expect(info[:distance]).to be_a(Float)
    end
  end
end
