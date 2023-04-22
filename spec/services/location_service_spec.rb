require "rails_helper"

RSpec.describe LocationService do 
  before(:each) do 
    @service = LocationService.new("Denver, CO")
  end

  describe "exists and has an api call", :vcr do 
    it "is a service" do 
      expect(@service).to be_a(LocationService)
    end

    it "has a connection to faraday" do 
      expect(@service.conn).to be_a(Faraday::Connection)
    end

    it "takes a city, state location and returns lat/long coordinates" do 
      result = @service.convert_location
   
      expect(result).to be_a(Hash)
      expect(result).to have_key(:results)
      expect(result[:results].first).to have_key(:locations)
      expect(result[:results].first[:locations].first).to have_key(:latLng)
      expect(result[:results].first[:locations].first[:latLng]).to have_key(:lat)
      expect(result[:results].first[:locations].first[:latLng][:lat]).to be_a(Float)
      expect(result[:results].first[:locations].first[:latLng]).to have_key(:lng)
      expect(result[:results].first[:locations].first[:latLng][:lng]).to be_a(Float)
    end
  end
end