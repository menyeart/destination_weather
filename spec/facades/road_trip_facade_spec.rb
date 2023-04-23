require "rails_helper"

RSpec.describe RoadTripFacade do 

  describe "Weather Facade", :vcr do 
    it "exists" do 
      facade = RoadTripFacade.new("Los Angeles, CA", "New York City, NY")

      expect(facade).to be_a(RoadTripFacade)
    end

    it "creates a road trip object with attributes" do
      facade = RoadTripFacade.new("Los Angeles, CA", "New York City, NY") 
      trip = facade.create_road_trip

      expect(trip).to be_a(RoadTrip)
    end
  end
end